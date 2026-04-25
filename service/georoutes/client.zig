const aws = @import("aws");
const std = @import("std");

const calculate_isolines = @import("calculate_isolines.zig");
const calculate_route_matrix = @import("calculate_route_matrix.zig");
const calculate_routes = @import("calculate_routes.zig");
const optimize_waypoints = @import("optimize_waypoints.zig");
const snap_to_roads = @import("snap_to_roads.zig");
const CallOptions = @import("call_options.zig").CallOptions;

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
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Calculates areas that can be reached within specified time or distance
    /// thresholds from a given point. For example, you can use this operation to
    /// determine the area within a 30-minute drive of a store location, find
    /// neighborhoods within walking distance of a school, or identify delivery
    /// zones based on drive time.
    ///
    /// Isolines (also known as isochrones for time-based calculations) are useful
    /// for various applications including:
    ///
    /// * Service area visualization - Show customers the area you can serve within
    ///   promised delivery times
    /// * Site selection - Analyze potential business locations based on population
    ///   within travel distance
    /// * Site selection - Determine areas that can be reached within specified
    ///   response times
    ///
    /// Route preferences such as avoiding toll roads or ferries are treated as
    /// preferences rather than absolute restrictions. If a viable route cannot be
    /// calculated while honoring all preferences, some may be ignored.
    ///
    /// For more information, see [Calculate
    /// isolines](https://docs.aws.amazon.com/location/latest/developerguide/calculate-isolines.html) in the *Amazon Location Service Developer Guide*.
    pub fn calculateIsolines(self: *Self, allocator: std.mem.Allocator, input: calculate_isolines.CalculateIsolinesInput, options: CallOptions) !calculate_isolines.CalculateIsolinesOutput {
        return calculate_isolines.execute(self, allocator, input, options);
    }

    /// Use `CalculateRouteMatrix` to compute results for all pairs of Origins to
    /// Destinations. Each row corresponds to one entry in Origins. Each entry in
    /// the row corresponds to the route from that entry in Origins to an entry in
    /// Destinations positions.
    ///
    /// For more information, see [Calculate route
    /// matrix](https://docs.aws.amazon.com/location/latest/developerguide/calculate-route-matrix.html) in the *Amazon Location Service Developer Guide*.
    pub fn calculateRouteMatrix(self: *Self, allocator: std.mem.Allocator, input: calculate_route_matrix.CalculateRouteMatrixInput, options: CallOptions) !calculate_route_matrix.CalculateRouteMatrixOutput {
        return calculate_route_matrix.execute(self, allocator, input, options);
    }

    /// `CalculateRoutes` computes routes given the following required parameters:
    /// `Origin` and `Destination`.
    ///
    /// For more information, see [Calculate
    /// routes](https://docs.aws.amazon.com/location/latest/developerguide/calculate-routes.html) in the *Amazon Location Service Developer Guide*.
    pub fn calculateRoutes(self: *Self, allocator: std.mem.Allocator, input: calculate_routes.CalculateRoutesInput, options: CallOptions) !calculate_routes.CalculateRoutesOutput {
        return calculate_routes.execute(self, allocator, input, options);
    }

    /// `OptimizeWaypoints` calculates the optimal order to travel between a set of
    /// waypoints to minimize either the travel time or the distance travelled
    /// during the journey, based on road network restrictions and the traffic
    /// pattern data.
    ///
    /// For more information, see [Optimize
    /// waypoints](https://docs.aws.amazon.com/location/latest/developerguide/actions-optimize-waypoints.html) in the *Amazon Location Service Developer Guide*.
    pub fn optimizeWaypoints(self: *Self, allocator: std.mem.Allocator, input: optimize_waypoints.OptimizeWaypointsInput, options: CallOptions) !optimize_waypoints.OptimizeWaypointsOutput {
        return optimize_waypoints.execute(self, allocator, input, options);
    }

    /// `SnapToRoads` matches GPS trace to roads most likely traveled on.
    ///
    /// For more information, see [Snap to
    /// Roads](https://docs.aws.amazon.com/location/latest/developerguide/snap-to-roads.html) in the *Amazon Location Service Developer Guide*.
    pub fn snapToRoads(self: *Self, allocator: std.mem.Allocator, input: snap_to_roads.SnapToRoadsInput, options: CallOptions) !snap_to_roads.SnapToRoadsOutput {
        return snap_to_roads.execute(self, allocator, input, options);
    }
};
