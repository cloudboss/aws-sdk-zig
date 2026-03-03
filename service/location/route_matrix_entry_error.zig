const RouteMatrixErrorCode = @import("route_matrix_error_code.zig").RouteMatrixErrorCode;

/// An error corresponding to the calculation of a route between the
/// `DeparturePosition` and `DestinationPosition`.
///
/// The error code can be one of the following:
///
/// * `RouteNotFound` - Unable to find a valid route with the given parameters.
///
/// * `RouteTooLong` - Route calculation went beyond the maximum size of a route
///   and was terminated before completion.
///
/// * `PositionsNotFound` - One or more of the input positions were not found on
///   the route network.
///
/// * `DestinationPositionNotFound` - The destination position was not found on
///   the route network.
///
/// * `DeparturePositionNotFound` - The departure position was not found on the
///   route network.
///
/// * `OtherValidationError` - The given inputs were not valid or a route was
///   not found. More information is given in the error `Message`
pub const RouteMatrixEntryError = struct {
    /// The type of error which occurred for the route calculation.
    code: RouteMatrixErrorCode,

    /// A message about the error that occurred for the route calculation.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};
