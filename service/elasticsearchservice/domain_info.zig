const EngineType = @import("engine_type.zig").EngineType;

pub const DomainInfo = struct {
    /// Specifies the `DomainName`.
    domain_name: ?[]const u8,

    /// Specifies the `EngineType` of the domain.
    engine_type: ?EngineType,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .engine_type = "EngineType",
    };
};
