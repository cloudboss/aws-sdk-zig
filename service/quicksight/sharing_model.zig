pub const SharingModel = enum {
    account,
    namespace,

    pub const json_field_names = .{
        .account = "ACCOUNT",
        .namespace = "NAMESPACE",
    };
};
