/// Information about the configuration of an integrated development environment
/// (IDE) for a Dev Environment.
pub const IdeConfiguration = struct {
    /// The name of the IDE. Valid values include `Cloud9`, `IntelliJ`, `PyCharm`,
    /// `GoLand`, and `VSCode`.
    name: ?[]const u8,

    /// A link to the IDE runtime image.
    ///
    /// This parameter is not required for `VSCode`.
    runtime: ?[]const u8,

    pub const json_field_names = .{
        .name = "name",
        .runtime = "runtime",
    };
};
