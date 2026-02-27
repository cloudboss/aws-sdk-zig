const Parameter = @import("parameter.zig").Parameter;

/// Contains the result of a successful invocation of the
/// `DescribeEngineDefaultParameters` action.
pub const EngineDefaults = struct {
    /// Specifies the name of the DB parameter group family that the engine default
    /// parameters apply to.
    db_parameter_group_family: ?[]const u8,

    /// An optional pagination token provided by a previous EngineDefaults request.
    /// If this parameter is specified, the response includes only records beyond
    /// the marker, up to the value specified by `MaxRecords` .
    marker: ?[]const u8,

    /// Contains a list of engine default parameters.
    parameters: ?[]const Parameter,
};
