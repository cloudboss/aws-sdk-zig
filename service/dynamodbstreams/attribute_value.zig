const aws = @import("aws");

/// Represents the data for an attribute.
///
/// Each attribute value is described as a name-value pair. The name is the data
/// type, and the value is the data itself.
///
/// For more information, see [Data
/// Types](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.NamingRulesDataTypes.html#HowItWorks.DataTypes) in the
/// *Amazon DynamoDB Developer Guide*.
pub const AttributeValue = union(enum) {
    /// An attribute of type Binary. For example:
    ///
    /// `"B": "dGhpcyB0ZXh0IGlzIGJhc2U2NC1lbmNvZGVk"`
    b: ?[]const u8,
    /// An attribute of type Boolean. For example:
    ///
    /// `"BOOL": true`
    bool: ?bool,
    /// An attribute of type Binary Set. For example:
    ///
    /// `"BS": ["U3Vubnk=", "UmFpbnk=", "U25vd3k="]`
    bs: ?[]const []const u8,
    /// An attribute of type List. For example:
    ///
    /// `"L": [ {"S": "Cookies"} , {"S": "Coffee"}, {"N": "3.14159"}]`
    l: ?[]const AttributeValue,
    /// An attribute of type Map. For example:
    ///
    /// `"M": {"Name": {"S": "Joe"}, "Age": {"N": "35"}}`
    m: ?[]const aws.map.MapEntry(AttributeValue),
    /// An attribute of type Number. For example:
    ///
    /// `"N": "123.45"`
    ///
    /// Numbers are sent across the network to DynamoDB as strings, to maximize
    /// compatibility across languages and libraries. However, DynamoDB treats them
    /// as number type attributes for mathematical operations.
    n: ?[]const u8,
    /// An attribute of type Number Set. For example:
    ///
    /// `"NS": ["42.2", "-19", "7.5", "3.14"]`
    ///
    /// Numbers are sent across the network to DynamoDB as strings, to maximize
    /// compatibility across languages and libraries. However, DynamoDB treats them
    /// as number type attributes for mathematical operations.
    ns: ?[]const []const u8,
    /// An attribute of type Null. For example:
    ///
    /// `"NULL": true`
    null: ?bool,
    /// An attribute of type String. For example:
    ///
    /// `"S": "Hello"`
    s: ?[]const u8,
    /// An attribute of type String Set. For example:
    ///
    /// `"SS": ["Giraffe", "Hippo" ,"Zebra"]`
    ss: ?[]const []const u8,

    pub const json_field_names = .{
        .b = "B",
        .bool = "BOOL",
        .bs = "BS",
        .l = "L",
        .m = "M",
        .n = "N",
        .ns = "NS",
        .null = "NULL",
        .s = "S",
        .ss = "SS",
    };
};
