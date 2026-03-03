/// The values of a given attribute, such as `Throughput Optimized HDD` or
/// `Provisioned
/// IOPS` for the `Amazon EC2`
/// `volumeType` attribute.
pub const AttributeValue = struct {
    /// The specific value of an `attributeName`.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .value = "Value",
    };
};
