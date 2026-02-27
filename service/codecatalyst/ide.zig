/// Information about an integrated development environment (IDE) used in a Dev
/// Environment.
pub const Ide = struct {
    /// The name of the IDE.
    name: ?[]const u8,

    /// A link to the IDE runtime image.
    runtime: ?[]const u8,

    pub const json_field_names = .{
        .name = "name",
        .runtime = "runtime",
    };
};
