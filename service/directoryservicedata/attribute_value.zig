/// The data type for an attribute. Each attribute value is described as a
/// name-value pair.
/// The name is the AD schema name, and the value is the data itself. For a list
/// of supported
/// attributes, see [Directory Service Data
/// Attributes](https://docs.aws.amazon.com/directoryservice/latest/admin-guide/ad_data_attributes.html).
pub const AttributeValue = union(enum) {
    /// Indicates that the attribute type value is a boolean. For example:
    ///
    /// `"BOOL": true`
    bool: ?bool,
    /// Indicates that the attribute type value is a number. For example:
    ///
    /// `"N": "16"`
    n: ?i64,
    /// Indicates that the attribute type value is a string. For example:
    ///
    /// `"S": "S Group"`
    s: ?[]const u8,
    /// Indicates that the attribute type value is a string set. For example:
    ///
    /// `"SS": ["sample_service_class/host.sample.com:1234/sample_service_name_1",
    /// "sample_service_class/host.sample.com:1234/sample_service_name_2"]`
    ss: ?[]const []const u8,

    pub const json_field_names = .{
        .bool = "BOOL",
        .n = "N",
        .s = "S",
        .ss = "SS",
    };
};
