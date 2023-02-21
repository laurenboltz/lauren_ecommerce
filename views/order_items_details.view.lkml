view: order_items_details {
    derived_table: {
      explore_source: order_items {
        column: total_profit {}
        column: state { field: users.state }
      }
    }
    dimension: total_profit {
      description: ""
      value_format: "$#,##0.00"
      type: number
    }
    dimension: state {
      description: ""
    }

    measure: total_profit_measure {
      type: number
      sql: ${total_profit} ;;
      value_format_name:usd
      html: {{ rendered_value }} | {{percent_of_total_profit._rendered_value }} of total ;;

    }

    measure: percent_of_total_profit {
      type: number
      sql: ${total_profit}/sum(${total_profit}) ;;
    }

  }
