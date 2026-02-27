/// The model of the API.
pub const Model = union(enum) {
    /// Indicates the smithy model of the API.
    smithy: ?[]const u8,

    pub const json_field_names = .{
        .smithy = "smithy",
    };
};
