const Parameter = @import("parameter.zig").Parameter;

/// Contains the result of a successful invocation of the
/// `DescribeEngineDefaultClusterParameters` operation.
pub const EngineDefaults = struct {
    /// The name of the cluster parameter group family to return the engine
    /// parameter information for.
    db_parameter_group_family: ?[]const u8,

    /// An optional pagination token provided by a previous request. If this
    /// parameter is specified, the response
    /// includes only records beyond the marker, up to the value specified by
    /// `MaxRecords`.
    marker: ?[]const u8,

    /// The parameters of a particular cluster parameter group family.
    parameters: ?[]const Parameter,
};
