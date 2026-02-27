/// Supports HbbTV specification as indicated
pub const DashIsoHbbtvCompliance = enum {
    hbbtv_1_5,
    none,

    pub const json_field_names = .{
        .hbbtv_1_5 = "HBBTV_1_5",
        .none = "NONE",
    };
};
