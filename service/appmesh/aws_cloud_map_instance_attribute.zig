/// An object that represents the Cloud Map attribute information for your
/// virtual node.
///
/// Cloud Map is not available in the eu-south-1 Region.
pub const AwsCloudMapInstanceAttribute = struct {
    /// The name of an Cloud Map service instance attribute key. Any Cloud Map
    /// service instance that contains the specified key and value is
    /// returned.
    key: []const u8,

    /// The value of an Cloud Map service instance attribute key. Any Cloud Map
    /// service instance that contains the specified key and value is
    /// returned.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
