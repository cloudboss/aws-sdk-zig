/// The types of identifiers that may be needed for remote account
/// specification.
pub const RemoteAccountIdentifier = union(enum) {
    /// A generic bit of identifying information. Can be used in place of any of the
    /// more specific types.
    identifier: ?[]const u8,

    pub const json_field_names = .{
        .identifier = "identifier",
    };
};
