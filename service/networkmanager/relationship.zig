/// Describes a resource relationship.
pub const Relationship = struct {
    /// The ARN of the resource.
    from: ?[]const u8 = null,

    /// The ARN of the resource.
    to: ?[]const u8 = null,

    pub const json_field_names = .{
        .from = "From",
        .to = "To",
    };
};
