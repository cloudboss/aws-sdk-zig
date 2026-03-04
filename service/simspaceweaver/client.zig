const aws = @import("aws");
const std = @import("std");

const create_snapshot = @import("create_snapshot.zig");
const delete_app = @import("delete_app.zig");
const delete_simulation = @import("delete_simulation.zig");
const describe_app = @import("describe_app.zig");
const describe_simulation = @import("describe_simulation.zig");
const list_apps = @import("list_apps.zig");
const list_simulations = @import("list_simulations.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const start_app = @import("start_app.zig");
const start_clock = @import("start_clock.zig");
const start_simulation = @import("start_simulation.zig");
const stop_app = @import("stop_app.zig");
const stop_clock = @import("stop_clock.zig");
const stop_simulation = @import("stop_simulation.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "SimSpaceWeaver";

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

    /// Creates a snapshot of the specified simulation.
    /// A snapshot is a file that contains simulation state data at a specific time.
    /// The state data saved in a snapshot includes entity data from the State
    /// Fabric,
    /// the simulation configuration specified in the schema, and the clock tick
    /// number.
    /// You can use the snapshot to initialize a new simulation.
    /// For more information about snapshots, see
    /// [Snapshots](https://docs.aws.amazon.com/simspaceweaver/latest/userguide/working-with_snapshots.html)
    /// in the *SimSpace Weaver User Guide*.
    ///
    /// You specify a `Destination` when you create a snapshot.
    /// The `Destination` is the name of an Amazon S3 bucket and an optional
    /// `ObjectKeyPrefix`. The `ObjectKeyPrefix` is
    /// usually the name of a folder in the bucket. SimSpace Weaver creates a
    /// `snapshot` folder inside the `Destination` and
    /// places the snapshot file there.
    ///
    /// The snapshot file is an Amazon S3 object. It has an object key with the
    /// form: `
    /// *object-key-prefix*/snapshot/*simulation-name*-*YYMMdd*-*HHmm*-*ss*.zip`,
    /// where:
    ///
    /// * `
    /// *YY*
    /// ` is the 2-digit year
    ///
    /// * `
    /// *MM*
    /// ` is the 2-digit month
    ///
    /// * `
    /// *dd*
    /// ` is the 2-digit day of the month
    ///
    /// * `
    /// *HH*
    /// ` is the 2-digit hour (24-hour clock)
    ///
    /// * `
    /// *mm*
    /// ` is the 2-digit minutes
    ///
    /// * `
    /// *ss*
    /// ` is the 2-digit seconds
    pub fn createSnapshot(self: *Self, allocator: std.mem.Allocator, input: create_snapshot.CreateSnapshotInput, options: CallOptions) !create_snapshot.CreateSnapshotOutput {
        return create_snapshot.execute(self, allocator, input, options);
    }

    /// Deletes the instance of the given custom app.
    pub fn deleteApp(self: *Self, allocator: std.mem.Allocator, input: delete_app.DeleteAppInput, options: CallOptions) !delete_app.DeleteAppOutput {
        return delete_app.execute(self, allocator, input, options);
    }

    /// Deletes all SimSpace Weaver resources assigned to the given simulation.
    ///
    /// Your simulation uses resources in other Amazon Web Services. This API
    /// operation doesn't delete
    /// resources in other Amazon Web Services.
    pub fn deleteSimulation(self: *Self, allocator: std.mem.Allocator, input: delete_simulation.DeleteSimulationInput, options: CallOptions) !delete_simulation.DeleteSimulationOutput {
        return delete_simulation.execute(self, allocator, input, options);
    }

    /// Returns the state of the given custom app.
    pub fn describeApp(self: *Self, allocator: std.mem.Allocator, input: describe_app.DescribeAppInput, options: CallOptions) !describe_app.DescribeAppOutput {
        return describe_app.execute(self, allocator, input, options);
    }

    /// Returns the current state of the given simulation.
    pub fn describeSimulation(self: *Self, allocator: std.mem.Allocator, input: describe_simulation.DescribeSimulationInput, options: CallOptions) !describe_simulation.DescribeSimulationOutput {
        return describe_simulation.execute(self, allocator, input, options);
    }

    /// Lists all custom apps or service apps for the given simulation and domain.
    pub fn listApps(self: *Self, allocator: std.mem.Allocator, input: list_apps.ListAppsInput, options: CallOptions) !list_apps.ListAppsOutput {
        return list_apps.execute(self, allocator, input, options);
    }

    /// Lists the SimSpace Weaver simulations in the Amazon Web Services account
    /// used to make the API call.
    pub fn listSimulations(self: *Self, allocator: std.mem.Allocator, input: list_simulations.ListSimulationsInput, options: CallOptions) !list_simulations.ListSimulationsOutput {
        return list_simulations.execute(self, allocator, input, options);
    }

    /// Lists all tags on a SimSpace Weaver resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Starts a custom app with the configuration specified in the simulation
    /// schema.
    pub fn startApp(self: *Self, allocator: std.mem.Allocator, input: start_app.StartAppInput, options: CallOptions) !start_app.StartAppOutput {
        return start_app.execute(self, allocator, input, options);
    }

    /// Starts the simulation clock.
    pub fn startClock(self: *Self, allocator: std.mem.Allocator, input: start_clock.StartClockInput, options: CallOptions) !start_clock.StartClockOutput {
        return start_clock.execute(self, allocator, input, options);
    }

    /// Starts a simulation with the given name. You must choose to start your
    /// simulation from a schema or from a snapshot.
    /// For more information about the schema, see the [schema
    /// reference](https://docs.aws.amazon.com/simspaceweaver/latest/userguide/schema-reference.html)
    /// in the *SimSpace Weaver User Guide*.
    /// For more information about snapshots, see
    /// [Snapshots](https://docs.aws.amazon.com/simspaceweaver/latest/userguide/working-with_snapshots.html)
    /// in the *SimSpace Weaver User Guide*.
    pub fn startSimulation(self: *Self, allocator: std.mem.Allocator, input: start_simulation.StartSimulationInput, options: CallOptions) !start_simulation.StartSimulationOutput {
        return start_simulation.execute(self, allocator, input, options);
    }

    /// Stops the given custom app and shuts down all of its allocated compute
    /// resources.
    pub fn stopApp(self: *Self, allocator: std.mem.Allocator, input: stop_app.StopAppInput, options: CallOptions) !stop_app.StopAppOutput {
        return stop_app.execute(self, allocator, input, options);
    }

    /// Stops the simulation clock.
    pub fn stopClock(self: *Self, allocator: std.mem.Allocator, input: stop_clock.StopClockInput, options: CallOptions) !stop_clock.StopClockOutput {
        return stop_clock.execute(self, allocator, input, options);
    }

    /// Stops the given simulation.
    ///
    /// You can't restart a simulation after you stop it. If you want to restart a
    /// simulation, then
    /// you must stop it, delete it, and start a new instance of it.
    pub fn stopSimulation(self: *Self, allocator: std.mem.Allocator, input: stop_simulation.StopSimulationInput, options: CallOptions) !stop_simulation.StopSimulationOutput {
        return stop_simulation.execute(self, allocator, input, options);
    }

    /// Adds tags to a SimSpace Weaver resource. For more information about tags,
    /// see [Tagging Amazon Web Services
    /// resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// in the
    /// *Amazon Web Services General Reference*.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from a SimSpace Weaver resource. For more information about
    /// tags, see [Tagging Amazon Web Services
    /// resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// in the
    /// *Amazon Web Services General Reference*.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    pub fn listAppsPaginator(self: *Self, params: list_apps.ListAppsInput) paginator.ListAppsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSimulationsPaginator(self: *Self, params: list_simulations.ListSimulationsInput) paginator.ListSimulationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
