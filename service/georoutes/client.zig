const aws = @import("aws");
const std = @import("std");

const calculate_isolines = @import("calculate_isolines.zig");
const calculate_route_matrix = @import("calculate_route_matrix.zig");
const calculate_routes = @import("calculate_routes.zig");
const optimize_waypoints = @import("optimize_waypoints.zig");
const snap_to_roads = @import("snap_to_roads.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Geo Routes";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Use the `CalculateIsolines` action to find service areas that can be reached
    /// in a given threshold of time, distance.
    pub fn calculateIsolines(self: *Self, allocator: std.mem.Allocator, input: calculate_isolines.CalculateIsolinesInput, options: calculate_isolines.Options) !calculate_isolines.CalculateIsolinesOutput {
        return calculate_isolines.execute(self, allocator, input, options);
    }

    /// Use `CalculateRouteMatrix` to compute results for all pairs of Origins to
    /// Destinations. Each row corresponds to one entry in Origins. Each entry in
    /// the row corresponds to the route from that entry in Origins to an entry in
    /// Destinations positions.
    pub fn calculateRouteMatrix(self: *Self, allocator: std.mem.Allocator, input: calculate_route_matrix.CalculateRouteMatrixInput, options: calculate_route_matrix.Options) !calculate_route_matrix.CalculateRouteMatrixOutput {
        return calculate_route_matrix.execute(self, allocator, input, options);
    }

    /// `CalculateRoutes` computes routes given the following required parameters:
    /// `Origin` and `Destination`.
    pub fn calculateRoutes(self: *Self, allocator: std.mem.Allocator, input: calculate_routes.CalculateRoutesInput, options: calculate_routes.Options) !calculate_routes.CalculateRoutesOutput {
        return calculate_routes.execute(self, allocator, input, options);
    }

    /// `OptimizeWaypoints` calculates the optimal order to travel between a set of
    /// waypoints to minimize either the travel time or the distance travelled
    /// during the journey, based on road network restrictions and the traffic
    /// pattern data.
    pub fn optimizeWaypoints(self: *Self, allocator: std.mem.Allocator, input: optimize_waypoints.OptimizeWaypointsInput, options: optimize_waypoints.Options) !optimize_waypoints.OptimizeWaypointsOutput {
        return optimize_waypoints.execute(self, allocator, input, options);
    }

    /// `SnapToRoads` matches GPS trace to roads most likely traveled on.
    pub fn snapToRoads(self: *Self, allocator: std.mem.Allocator, input: snap_to_roads.SnapToRoadsInput, options: snap_to_roads.Options) !snap_to_roads.SnapToRoadsOutput {
        return snap_to_roads.execute(self, allocator, input, options);
    }
};
