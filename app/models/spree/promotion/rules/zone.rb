module Spree
  class Promotion
    module Rules
      class Zone < Spree::PromotionRule
        has_and_belongs_to_many :zones, class_name: '::Spree::Zone', join_table: 'spree_zones_promotion_rules', foreign_key: 'promotion_rule_id'

        def applicable?(promotable)
          promotable.is_a?(Spree::Order)
        end

        def eligible?(order, options = {})
          return false if order.ship_address.nil?
          zones.each do |zone|
            return true if zone.include?(order.ship_address)
          end
          false
        end

        def zone_ids_string
          zone_ids.join(',')
        end

        def zone_ids_string=(s)
          self.zone_ids = s.to_s.split(',').map(&:strip)
        end  

      end
    end
  end
end