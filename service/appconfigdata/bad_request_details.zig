const aws = @import("aws");

const InvalidParameterDetail = @import("invalid_parameter_detail.zig").InvalidParameterDetail;

/// Detailed information about the input that failed to satisfy the constraints
/// specified by
/// a call.
pub const BadRequestDetails = union(enum) {
    /// One or more specified parameters are not valid for the call.
    invalid_parameters: ?[]const aws.map.MapEntry(InvalidParameterDetail),

    pub const json_field_names = .{
        .invalid_parameters = "InvalidParameters",
    };
};
