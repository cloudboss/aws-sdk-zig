pub const RouteMatrixErrorCode = enum {
    route_not_found,
    route_too_long,
    positions_not_found,
    destination_position_not_found,
    departure_position_not_found,
    other_validation_error,

    pub const json_field_names = .{
        .route_not_found = "RouteNotFound",
        .route_too_long = "RouteTooLong",
        .positions_not_found = "PositionsNotFound",
        .destination_position_not_found = "DestinationPositionNotFound",
        .departure_position_not_found = "DeparturePositionNotFound",
        .other_validation_error = "OtherValidationError",
    };
};
