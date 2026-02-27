pub const CustomMetricType = enum {
    string_list,
    ip_address_list,
    number_list,
    number,

    pub const json_field_names = .{
        .string_list = "STRING_LIST",
        .ip_address_list = "IP_ADDRESS_LIST",
        .number_list = "NUMBER_LIST",
        .number = "NUMBER",
    };
};
