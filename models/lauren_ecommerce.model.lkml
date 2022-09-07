connection: "ecommerce_demo"

# include all the views
include: "/views/**/*.view"

datagroup: lauren_ecommerce_docs_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: lauren_ecommerce_docs_default_datagroup


explore: order_items {
  group_label: "LoBo's eCommerce"
  query: order_count_by_month {
    label: "Order count by month"
    description: "Number of orders placed by month in 2019"
    dimensions: [orders.created_month]
    measures: [orders.count]
    filters: [orders.created_date: "2019"]
  }
  query: CA_order_count_by_month {
    label: "CA order count by month"
    description: "Number of orders placed in California by month in 2019"
    dimensions: [orders.created_month]
    measures: [orders.count]
    filters: [orders.created_date: "2019"]
    filters: [users.state: "California"]
  }
  query: order_count_by_state_by_month {
    label: "Order count by state by month"
    description: "Monthly order count and user count by state"
    dimensions: [orders.created_month, users.state]
    measures: [orders.count, users.count]
    filters: [orders.created_date: "2019"]
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

# explore: orders {
#   group_label: "eCommerce"
#   join: users {
#     type: left_outer
#     sql_on: ${orders.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: products {
#   group_label: "eCommerce"
# }


# explore: users {
#   group_label: "eCommerce"
# }



# explore: events {
#   join: users {
#     type: left_outer
#     sql_on: ${events.user_id} = ${users.id} ;;
#     relationship: many_to_one
#   }
# }

# explore: inventory_items {
#   join: products {
#     type: left_outer
#     sql_on: ${inventory_items.product_id} = ${products.id} ;;
#     relationship: many_to_one
#   }
# }
