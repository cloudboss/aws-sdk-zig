const ResolutionStrategy = @import("resolution_strategy.zig").ResolutionStrategy;

/// The summary of the account pool.
pub const AccountPoolSummary = struct {
    /// The user who created the account pool.
    created_by: ?[]const u8,

    /// The ID of the domain.
    domain_id: ?[]const u8,

    /// The ID of the domain unit.
    domain_unit_id: ?[]const u8,

    /// The ID of the account pool.
    id: ?[]const u8,

    /// The name of the account pool.
    name: ?[]const u8,

    /// The mechanism used to resolve the account selection from the account pool.
    resolution_strategy: ?ResolutionStrategy,

    /// The user who updated the account pool.
    updated_by: ?[]const u8,

    pub const json_field_names = .{
        .created_by = "createdBy",
        .domain_id = "domainId",
        .domain_unit_id = "domainUnitId",
        .id = "id",
        .name = "name",
        .resolution_strategy = "resolutionStrategy",
        .updated_by = "updatedBy",
    };
};
