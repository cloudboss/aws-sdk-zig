/// The parameters for Presto.
pub const PrestoParameters = struct {
    /// Catalog.
    catalog: []const u8,

    /// Host.
    host: []const u8,

    /// Port.
    port: i32,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .host = "Host",
        .port = "Port",
    };
};
