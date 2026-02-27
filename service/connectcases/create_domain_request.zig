pub const CreateDomainRequest = struct {
    /// The name for your Cases domain. It must be unique for your Amazon Web
    /// Services account.
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};
