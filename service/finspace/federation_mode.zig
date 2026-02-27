pub const FederationMode = enum {
    federated,
    local,

    pub const json_field_names = .{
        .federated = "FEDERATED",
        .local = "LOCAL",
    };
};
