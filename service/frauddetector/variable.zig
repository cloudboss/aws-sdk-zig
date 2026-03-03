const DataSource = @import("data_source.zig").DataSource;
const DataType = @import("data_type.zig").DataType;

/// The variable.
pub const Variable = struct {
    /// The ARN of the variable.
    arn: ?[]const u8 = null,

    /// The time when the variable was created.
    created_time: ?[]const u8 = null,

    /// The data source of the variable.
    data_source: ?DataSource = null,

    /// The data type of the variable. For more information see [Variable
    /// types](https://docs.aws.amazon.com/frauddetector/latest/ug/create-a-variable.html#variable-types).
    data_type: ?DataType = null,

    /// The default value of the variable.
    default_value: ?[]const u8 = null,

    /// The description of the variable.
    description: ?[]const u8 = null,

    /// The time when variable was last updated.
    last_updated_time: ?[]const u8 = null,

    /// The name of the variable.
    name: ?[]const u8 = null,

    /// The variable type of the variable.
    ///
    /// Valid Values: `AUTH_CODE | AVS | BILLING_ADDRESS_L1 | BILLING_ADDRESS_L2 |
    /// BILLING_CITY | BILLING_COUNTRY | BILLING_NAME | BILLING_PHONE |
    /// BILLING_STATE | BILLING_ZIP | CARD_BIN | CATEGORICAL | CURRENCY_CODE |
    /// EMAIL_ADDRESS | FINGERPRINT | FRAUD_LABEL | FREE_FORM_TEXT | IP_ADDRESS |
    /// NUMERIC | ORDER_ID | PAYMENT_TYPE | PHONE_NUMBER | PRICE | PRODUCT_CATEGORY
    /// | SHIPPING_ADDRESS_L1 | SHIPPING_ADDRESS_L2 | SHIPPING_CITY |
    /// SHIPPING_COUNTRY | SHIPPING_NAME | SHIPPING_PHONE | SHIPPING_STATE |
    /// SHIPPING_ZIP | USERAGENT `
    variable_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_time = "createdTime",
        .data_source = "dataSource",
        .data_type = "dataType",
        .default_value = "defaultValue",
        .description = "description",
        .last_updated_time = "lastUpdatedTime",
        .name = "name",
        .variable_type = "variableType",
    };
};
