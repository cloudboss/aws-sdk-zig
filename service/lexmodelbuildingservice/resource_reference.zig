/// Describes the resource that refers to the resource that you are
/// attempting to delete. This object is returned as part of the
/// `ResourceInUseException` exception.
pub const ResourceReference = struct {
    /// The name of the resource that is using the resource that you are
    /// trying to delete.
    name: ?[]const u8,

    /// The version of the resource that is using the resource that you are
    /// trying to delete.
    version: ?[]const u8,

    pub const json_field_names = .{
        .name = "name",
        .version = "version",
    };
};
