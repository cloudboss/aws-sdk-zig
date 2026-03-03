/// A variable in the list of variables for the batch create variable request.
pub const VariableEntry = struct {
    /// The data source of the variable.
    data_source: ?[]const u8 = null,

    /// The data type of the variable.
    data_type: ?[]const u8 = null,

    /// The default value of the variable.
    default_value: ?[]const u8 = null,

    /// The description of the variable.
    description: ?[]const u8 = null,

    /// The name of the variable.
    name: ?[]const u8 = null,

    /// The type of the variable. For more information see [Variable
    /// types](https://docs.aws.amazon.com/frauddetector/latest/ug/create-a-variable.html#variable-types).
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
        .data_source = "dataSource",
        .data_type = "dataType",
        .default_value = "defaultValue",
        .description = "description",
        .name = "name",
        .variable_type = "variableType",
    };
};
