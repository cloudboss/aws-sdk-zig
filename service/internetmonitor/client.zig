const aws = @import("aws");
const std = @import("std");

const create_monitor = @import("create_monitor.zig");
const delete_monitor = @import("delete_monitor.zig");
const get_health_event = @import("get_health_event.zig");
const get_internet_event = @import("get_internet_event.zig");
const get_monitor = @import("get_monitor.zig");
const get_query_results = @import("get_query_results.zig");
const get_query_status = @import("get_query_status.zig");
const list_health_events = @import("list_health_events.zig");
const list_internet_events = @import("list_internet_events.zig");
const list_monitors = @import("list_monitors.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const start_query = @import("start_query.zig");
const stop_query = @import("stop_query.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_monitor = @import("update_monitor.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "InternetMonitor";

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

    /// Creates a monitor in Amazon CloudWatch Internet Monitor. A monitor is built
    /// based on information from the application resources that you add: VPCs,
    /// Network Load Balancers (NLBs), Amazon CloudFront distributions, and Amazon
    /// WorkSpaces directories. Internet Monitor then publishes internet
    /// measurements from Amazon Web Services
    /// that are specific to the *city-networks*. That is, the locations and ASNs
    /// (typically internet service providers or ISPs),
    /// where clients access your application. For more information, see [Using
    /// Amazon CloudWatch Internet
    /// Monitor](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-InternetMonitor.html) in the *Amazon CloudWatch User
    /// Guide*.
    ///
    /// When you create a monitor, you choose the percentage of traffic that you
    /// want to monitor. You can also set a maximum limit for the
    /// number of city-networks where client traffic is monitored, that caps the
    /// total traffic that Internet Monitor monitors. A city-network
    /// maximum is the limit of city-networks, but you only pay for the number of
    /// city-networks that are actually monitored. You can update your monitor
    /// at any time to change the percentage of traffic to monitor or the
    /// city-networks maximum. For more information, see [Choosing a city-network
    /// maximum
    /// value](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/IMCityNetworksMaximum.html) in the *Amazon CloudWatch User Guide*.
    pub fn createMonitor(self: *Self, allocator: std.mem.Allocator, input: create_monitor.CreateMonitorInput, options: CallOptions) !create_monitor.CreateMonitorOutput {
        return create_monitor.execute(self, allocator, input, options);
    }

    /// Deletes a monitor in Amazon CloudWatch Internet Monitor.
    pub fn deleteMonitor(self: *Self, allocator: std.mem.Allocator, input: delete_monitor.DeleteMonitorInput, options: CallOptions) !delete_monitor.DeleteMonitorOutput {
        return delete_monitor.execute(self, allocator, input, options);
    }

    /// Gets information that Amazon CloudWatch Internet Monitor has created and
    /// stored about a health event for a specified monitor. This information
    /// includes the impacted locations,
    /// and all the information related to the event, by location.
    ///
    /// The information returned includes the impact on performance, availability,
    /// and round-trip time, information about the network providers (ASNs),
    /// the event type, and so on.
    ///
    /// Information rolled up at the global traffic level is also returned,
    /// including the impact type and total traffic impact.
    pub fn getHealthEvent(self: *Self, allocator: std.mem.Allocator, input: get_health_event.GetHealthEventInput, options: CallOptions) !get_health_event.GetHealthEventOutput {
        return get_health_event.execute(self, allocator, input, options);
    }

    /// Gets information that Amazon CloudWatch Internet Monitor has generated about
    /// an internet event. Internet Monitor displays information about
    /// recent global health events, called internet events, on a global outages map
    /// that is available to all Amazon Web Services
    /// customers.
    ///
    /// The information returned here includes the impacted location,
    /// when the event started and (if the event is over) ended, the type of event
    /// (`PERFORMANCE` or `AVAILABILITY`),
    /// and the status (`ACTIVE` or `RESOLVED`).
    pub fn getInternetEvent(self: *Self, allocator: std.mem.Allocator, input: get_internet_event.GetInternetEventInput, options: CallOptions) !get_internet_event.GetInternetEventOutput {
        return get_internet_event.execute(self, allocator, input, options);
    }

    /// Gets information about a monitor in Amazon CloudWatch Internet Monitor based
    /// on a monitor name. The information returned includes the Amazon Resource
    /// Name (ARN), create time,
    /// modified time, resources included in the monitor, and status information.
    pub fn getMonitor(self: *Self, allocator: std.mem.Allocator, input: get_monitor.GetMonitorInput, options: CallOptions) !get_monitor.GetMonitorOutput {
        return get_monitor.execute(self, allocator, input, options);
    }

    /// Return the data for a query with the Amazon CloudWatch Internet Monitor
    /// query interface. Specify the query that you want to return results for by
    /// providing
    /// a `QueryId` and a monitor name.
    ///
    /// For more information about using the query interface, including examples,
    /// see
    /// [Using the Amazon CloudWatch Internet Monitor query
    /// interface](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-IM-view-cw-tools-cwim-query.html)
    /// in the Amazon CloudWatch Internet Monitor User Guide.
    pub fn getQueryResults(self: *Self, allocator: std.mem.Allocator, input: get_query_results.GetQueryResultsInput, options: CallOptions) !get_query_results.GetQueryResultsOutput {
        return get_query_results.execute(self, allocator, input, options);
    }

    /// Returns the current status of a query for the Amazon CloudWatch Internet
    /// Monitor query interface, for a specified query ID and monitor.
    /// When you run a query, check the status to make sure that the query has
    /// `SUCCEEDED` before you review the results.
    ///
    /// * `QUEUED`: The query is scheduled to run.
    ///
    /// * `RUNNING`: The query is in progress but not complete.
    ///
    /// * `SUCCEEDED`: The query completed sucessfully.
    ///
    /// * `FAILED`: The query failed due to an error.
    ///
    /// * `CANCELED`: The query was canceled.
    pub fn getQueryStatus(self: *Self, allocator: std.mem.Allocator, input: get_query_status.GetQueryStatusInput, options: CallOptions) !get_query_status.GetQueryStatusOutput {
        return get_query_status.execute(self, allocator, input, options);
    }

    /// Lists all health events for a monitor in Amazon CloudWatch Internet Monitor.
    /// Returns information for health events including the event start and end
    /// times, and
    /// the status.
    ///
    /// Health events that have start times during the time frame that is requested
    /// are not included in the list of health events.
    pub fn listHealthEvents(self: *Self, allocator: std.mem.Allocator, input: list_health_events.ListHealthEventsInput, options: CallOptions) !list_health_events.ListHealthEventsOutput {
        return list_health_events.execute(self, allocator, input, options);
    }

    /// Lists internet events that cause performance or availability issues for
    /// client locations. Amazon CloudWatch Internet Monitor displays information
    /// about
    /// recent global health events, called internet events, on a global outages map
    /// that is available to all Amazon Web Services
    /// customers.
    ///
    /// You can constrain the list of internet events returned by providing a start
    /// time and end time to define a total
    /// time frame for events you want to list. Both start time and end time specify
    /// the time when an event started. End time
    /// is optional. If you don't include it, the default end time is the current
    /// time.
    ///
    /// You can also limit the events returned to a specific status
    /// (`ACTIVE` or `RESOLVED`) or type (`PERFORMANCE` or `AVAILABILITY`).
    pub fn listInternetEvents(self: *Self, allocator: std.mem.Allocator, input: list_internet_events.ListInternetEventsInput, options: CallOptions) !list_internet_events.ListInternetEventsOutput {
        return list_internet_events.execute(self, allocator, input, options);
    }

    /// Lists all of your monitors for Amazon CloudWatch Internet Monitor and their
    /// statuses, along with the Amazon Resource Name (ARN) and name of each
    /// monitor.
    pub fn listMonitors(self: *Self, allocator: std.mem.Allocator, input: list_monitors.ListMonitorsInput, options: CallOptions) !list_monitors.ListMonitorsOutput {
        return list_monitors.execute(self, allocator, input, options);
    }

    /// Lists the tags for a resource. Tags are supported only for monitors in
    /// Amazon CloudWatch Internet Monitor.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Start a query to return data for a specific query type for the Amazon
    /// CloudWatch Internet Monitor query interface. Specify a time period
    /// for the data that you want returned by using `StartTime` and `EndTime`. You
    /// filter the query
    /// results to return by providing parameters that you specify with
    /// `FilterParameters`.
    ///
    /// For more information about using the query interface, including examples,
    /// see
    /// [Using the Amazon CloudWatch Internet Monitor query
    /// interface](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-IM-view-cw-tools-cwim-query.html)
    /// in the Amazon CloudWatch Internet Monitor User Guide.
    pub fn startQuery(self: *Self, allocator: std.mem.Allocator, input: start_query.StartQueryInput, options: CallOptions) !start_query.StartQueryOutput {
        return start_query.execute(self, allocator, input, options);
    }

    /// Stop a query that is progress for a specific monitor.
    pub fn stopQuery(self: *Self, allocator: std.mem.Allocator, input: stop_query.StopQueryInput, options: CallOptions) !stop_query.StopQueryOutput {
        return stop_query.execute(self, allocator, input, options);
    }

    /// Adds a tag to a resource. Tags are supported only for monitors in Amazon
    /// CloudWatch Internet Monitor. You can add a maximum of 50 tags in Internet
    /// Monitor.
    ///
    /// A minimum of one tag is required for this call. It returns an error if you
    /// use the `TagResource` request with 0 tags.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a tag from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a monitor. You can update a monitor to change the percentage of
    /// traffic to monitor or the maximum number of city-networks
    /// (locations and ASNs), to add or remove resources, or to change the status of
    /// the monitor. Note that you can't change the name of a monitor.
    ///
    /// The city-network maximum that you choose is the limit, but you only pay for
    /// the number of city-networks that are actually monitored.
    /// For more information, see [Choosing a city-network maximum
    /// value](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/IMCityNetworksMaximum.html) in the *Amazon CloudWatch User Guide*.
    pub fn updateMonitor(self: *Self, allocator: std.mem.Allocator, input: update_monitor.UpdateMonitorInput, options: CallOptions) !update_monitor.UpdateMonitorOutput {
        return update_monitor.execute(self, allocator, input, options);
    }

    pub fn getQueryResultsPaginator(self: *Self, params: get_query_results.GetQueryResultsInput) paginator.GetQueryResultsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listHealthEventsPaginator(self: *Self, params: list_health_events.ListHealthEventsInput) paginator.ListHealthEventsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listInternetEventsPaginator(self: *Self, params: list_internet_events.ListInternetEventsInput) paginator.ListInternetEventsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listMonitorsPaginator(self: *Self, params: list_monitors.ListMonitorsInput) paginator.ListMonitorsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
