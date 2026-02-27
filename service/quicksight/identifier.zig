/// The definition for the identifier.
pub const Identifier = struct {
    /// The identity of the identifier.
    identity: []const u8,

    pub const json_field_names = .{
        .identity = "Identity",
    };
};
