pub const Client = @import("client.zig").Client;
pub const CallOptions = @import("call_options.zig").CallOptions;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;
pub const types = @import("types.zig");

pub const CalculateIsolinesInput = @import("calculate_isolines.zig").CalculateIsolinesInput;
pub const CalculateIsolinesOutput = @import("calculate_isolines.zig").CalculateIsolinesOutput;
pub const CalculateRouteMatrixInput = @import("calculate_route_matrix.zig").CalculateRouteMatrixInput;
pub const CalculateRouteMatrixOutput = @import("calculate_route_matrix.zig").CalculateRouteMatrixOutput;
pub const CalculateRoutesInput = @import("calculate_routes.zig").CalculateRoutesInput;
pub const CalculateRoutesOutput = @import("calculate_routes.zig").CalculateRoutesOutput;
pub const OptimizeWaypointsInput = @import("optimize_waypoints.zig").OptimizeWaypointsInput;
pub const OptimizeWaypointsOutput = @import("optimize_waypoints.zig").OptimizeWaypointsOutput;
pub const SnapToRoadsInput = @import("snap_to_roads.zig").SnapToRoadsInput;
pub const SnapToRoadsOutput = @import("snap_to_roads.zig").SnapToRoadsOutput;
