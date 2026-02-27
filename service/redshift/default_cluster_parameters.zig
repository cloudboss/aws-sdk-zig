const Parameter = @import("parameter.zig").Parameter;

/// Describes the default cluster parameters for a parameter group family.
pub const DefaultClusterParameters = struct {
    /// A value that indicates the starting point for the next set of response
    /// records in a
    /// subsequent request. If a value is returned in a response, you can retrieve
    /// the next set
    /// of records by providing this returned marker value in the `Marker` parameter
    /// and retrying the command. If the `Marker` field is empty, all response
    /// records have been retrieved for the request.
    marker: ?[]const u8,

    /// The name of the cluster parameter group family to which the engine default
    /// parameters apply.
    parameter_group_family: ?[]const u8,

    /// The list of cluster default parameters.
    parameters: ?[]const Parameter,
};
