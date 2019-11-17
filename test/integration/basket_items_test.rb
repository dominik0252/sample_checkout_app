require 'test_helper'

class BasketItemsTest < ActionDispatch::IntegrationTest
  def setup
    get root_url

    @basket = Basket.all.order(created_at: :desc).first

    @smart_hub_item                 = items(:smart_hub)
    @motion_sensor_item             = items(:motion_sensor)
    @wireless_camera_item           = items(:wireless_camera)
    @smoke_sensor_item              = items(:smoke_sensor)
    @twenty_pct_off_promotion       = promotions(:twenty_pct_off)
    @five_pct_off_promotion         = promotions(:five_pct_off)
    @twenty_eur_off_promotion       = promotions(:twenty_eur_off)
    @three_motion_sensors_promotion = promotions(:three_motion_sensors)
    @two_smoke_sensors_promotion    = promotions(:two_smoke_sensors)
  end

  test "basket item add remove" do
    assert_difference 'BasketItem.count', 1 do
      post basket_items_path, params: { basket_item: { type: 'PurchasingItem',
                                                       basket_id: @basket.id,
                                                       item_id: @motion_sensor_item.id } }
      follow_redirect!
      assert_template 'items/index'
    end
    assert_difference 'BasketItem.count', 1 do
      post basket_items_path, params: { basket_item: { type: 'UsingPromotion',
                                                       basket_id: @basket.id,
                                                       promotion_id: @twenty_pct_off_promotion.id } }
    end
    assert_difference 'BasketItem.count', -1 do
      delete basket_item_path(BasketItem.where( basket_id:    @basket.id,
                                                promotion_id: @twenty_pct_off_promotion.id)
                                        .first)
    end
    assert_difference 'BasketItem.count', -1 do
      delete basket_item_path(BasketItem.where( basket_id:  @basket.id,
                                                item_id:    @motion_sensor_item.id)
                                        .first)
    end
  end

  test "no promotion can be applied if no items in basket" do
    assert_no_difference 'BasketItem.count' do
      post basket_items_path, params: { basket_item: { type: 'UsingPromotion',
                                                       basket_id: @basket.id,
                                                       promotion_id: @twenty_pct_off_promotion.id } }
    end
  end

  test "code promotions conjunctions" do
    post basket_items_path, params: { basket_item: { type: 'PurchasingItem',
                                                     basket_id: @basket.id,
                                                     item_id: @motion_sensor_item.id } }
    post basket_items_path, params: { basket_item: { type: 'UsingPromotion',
                                                     basket_id: @basket.id,
                                                     promotion_id: @twenty_pct_off_promotion.id } }
    assert_no_difference 'BasketItem.count' do
      post basket_items_path, params: { basket_item: { type: 'UsingPromotion',
                                                       basket_id: @basket.id,
                                                       promotion_id: @five_pct_off_promotion.id } }
    end

    delete basket_item_path(BasketItem.where( basket_id:    @basket.id,
                                              promotion_id: @twenty_pct_off_promotion.id)
                                      .first)

    assert_difference 'BasketItem.count', 1 do
      post basket_items_path, params: { basket_item: { type: 'UsingPromotion',
                                                       basket_id: @basket.id,
                                                       promotion_id: @five_pct_off_promotion.id } }
    end

    assert_no_difference 'BasketItem.count' do
      post basket_items_path, params: { basket_item: { type: 'UsingPromotion',
                                                       basket_id: @basket.id,
                                                       promotion_id: @twenty_pct_off_promotion.id } }
    end

    assert_difference 'BasketItem.count', 1 do
      post basket_items_path, params: { basket_item: { type: 'UsingPromotion',
                                                       basket_id: @basket.id,
                                                       promotion_id: @twenty_eur_off_promotion.id } }
    end

    delete basket_item_path(BasketItem.where( basket_id:    @basket.id,
                                              promotion_id: @twenty_eur_off_promotion.id)
                                      .first)
    delete basket_item_path(BasketItem.where( basket_id:    @basket.id,
                                              promotion_id: @five_pct_off_promotion.id)
                                      .first)

    assert_difference 'BasketItem.count', 1 do
      post basket_items_path, params: { basket_item: { type: 'UsingPromotion',
                                                       basket_id: @basket.id,
                                                       promotion_id: @twenty_pct_off_promotion.id } }
    end

  end

  test "quantity promotion cannot be applied if not enough items in basket" do
    assert_difference 'BasketItem.count', 2 do
      2.times do
        post basket_items_path, params: { basket_item: { type: 'PurchasingItem',
                                                         basket_id: @basket.id,
                                                         item_id: @motion_sensor_item.id } }
      end
    end
    assert_no_difference 'BasketItem.count' do
      post basket_items_path, params: { basket_item: { type: 'UsingPromotion',
                                                       basket_id: @basket.id,
                                                       promotion_id: @three_motion_sensors_promotion.id } }
    end
    post basket_items_path, params: { basket_item: { type:      'PurchasingItem',
                                                     basket_id: @basket.id,
                                                     item_id:   @motion_sensor_item.id } }
    assert_difference 'BasketItem.count', 1 do
      post basket_items_path, params: { basket_item: { type:          'UsingPromotion',
                                                       basket_id:     @basket.id,
                                                       promotion_id:  @three_motion_sensors_promotion.id } }
    end
    post basket_items_path, params: { basket_item: { type:      'PurchasingItem',
                                                     basket_id: @basket.id,
                                                     item_id:   @motion_sensor_item.id } }
    assert_no_difference 'BasketItem.count' do
      post basket_items_path, params: { basket_item: { type: 'UsingPromotion',
                                                       basket_id: @basket.id,
                                                       promotion_id: @three_motion_sensors_promotion.id } }
    end
    post basket_items_path, params: { basket_item: { type: 'PurchasingItem',
                                                     basket_id: @basket.id,
                                                     item_id: @motion_sensor_item.id } }
    post basket_items_path, params: { basket_item: { type: 'PurchasingItem',
                                                     basket_id: @basket.id,
                                                     item_id: @motion_sensor_item.id } }
    assert_difference 'BasketItem.count', 1 do
      post basket_items_path, params: { basket_item: { type: 'UsingPromotion',
                                                       basket_id: @basket.id,
                                                       promotion_id: @three_motion_sensors_promotion.id } }
    end
  end

  test "remove promotion if removing item causes insufficient number of items for the promotion" do
    6.times do
      post basket_items_path, params: { basket_item: { type: 'PurchasingItem',
                                                       basket_id: @basket.id,
                                                       item_id: @motion_sensor_item.id } }
    end
    2.times do
      post basket_items_path, params: { basket_item: { type: 'UsingPromotion',
                                                       basket_id: @basket.id,
                                                       promotion_id: @three_motion_sensors_promotion.id } }
    end
    assert_difference 'BasketItem.count', -2 do
      delete basket_item_path(BasketItem.where( basket_id:  @basket.id,
                                                item_id:    @motion_sensor_item.id)
                                        .first)
    end
    assert_difference 'BasketItem.count', -1 do
      delete basket_item_path(BasketItem.where( basket_id:  @basket.id,
                                                item_id:    @motion_sensor_item.id)
                                        .first)
    end
  end

  test "calculate basket total amount" do
    2.times do
      post basket_items_path, params: { basket_item: { type: 'PurchasingItem',
                                                       basket_id: @basket.id,
                                                       item_id: @smart_hub_item.id } }

    end
    5.times do
      post basket_items_path, params: { basket_item: { type: 'PurchasingItem',
                                                       basket_id: @basket.id,
                                                       item_id: @motion_sensor_item.id } }
      post basket_items_path, params: { basket_item: { type: 'PurchasingItem',
                                                       basket_id: @basket.id,
                                                       item_id: @smoke_sensor_item.id } }
    end
    post basket_items_path, params: { basket_item: { type: 'PurchasingItem',
                                                     basket_id: @basket.id,
                                                     item_id: @wireless_camera_item.id } }
    post basket_items_path, params: { basket_item: { type: 'UsingPromotion',
                                                     basket_id: @basket.id,
                                                     promotion_id: @three_motion_sensors_promotion.id } }
    2.times do
      post basket_items_path, params: { basket_item: { type: 'UsingPromotion',
                                                       basket_id: @basket.id,
                                                       promotion_id: @two_smoke_sensors_promotion.id } }
    end
    post basket_items_path, params: { basket_item: { type: 'UsingPromotion',
                                                     basket_id: @basket.id,
                                                     promotion_id: @five_pct_off_promotion.id } }
    post basket_items_path, params: { basket_item: { type: 'UsingPromotion',
                                                     basket_id: @basket.id,
                                                     promotion_id: @twenty_eur_off_promotion.id } }

    assert_equal @basket.calculate_total_amount, 365.69
  end
end
