const aws = @import("aws");
const std = @import("std");

const cancel_contact = @import("cancel_contact.zig");
const create_config = @import("create_config.zig");
const create_dataflow_endpoint_group = @import("create_dataflow_endpoint_group.zig");
const create_dataflow_endpoint_group_v2 = @import("create_dataflow_endpoint_group_v2.zig");
const create_ephemeris = @import("create_ephemeris.zig");
const create_mission_profile = @import("create_mission_profile.zig");
const delete_config = @import("delete_config.zig");
const delete_dataflow_endpoint_group = @import("delete_dataflow_endpoint_group.zig");
const delete_ephemeris = @import("delete_ephemeris.zig");
const delete_mission_profile = @import("delete_mission_profile.zig");
const describe_contact = @import("describe_contact.zig");
const describe_ephemeris = @import("describe_ephemeris.zig");
const get_agent_configuration = @import("get_agent_configuration.zig");
const get_agent_task_response_url = @import("get_agent_task_response_url.zig");
const get_config = @import("get_config.zig");
const get_dataflow_endpoint_group = @import("get_dataflow_endpoint_group.zig");
const get_minute_usage = @import("get_minute_usage.zig");
const get_mission_profile = @import("get_mission_profile.zig");
const get_satellite = @import("get_satellite.zig");
const list_configs = @import("list_configs.zig");
const list_contacts = @import("list_contacts.zig");
const list_dataflow_endpoint_groups = @import("list_dataflow_endpoint_groups.zig");
const list_ephemerides = @import("list_ephemerides.zig");
const list_ground_stations = @import("list_ground_stations.zig");
const list_mission_profiles = @import("list_mission_profiles.zig");
const list_satellites = @import("list_satellites.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const register_agent = @import("register_agent.zig");
const reserve_contact = @import("reserve_contact.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_agent_status = @import("update_agent_status.zig");
const update_config = @import("update_config.zig");
const update_ephemeris = @import("update_ephemeris.zig");
const update_mission_profile = @import("update_mission_profile.zig");
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "GroundStation";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Cancels or stops a contact with a specified contact ID based on its position
    /// in the [contact
    /// lifecycle](https://docs.aws.amazon.com/ground-station/latest/ug/contacts.lifecycle.html).
    ///
    /// For contacts that:
    ///
    /// * Have yet to start, the contact will be cancelled.
    /// * Have started but have yet to finish, the contact will be stopped.
    pub fn cancelContact(self: *Self, allocator: std.mem.Allocator, input: cancel_contact.CancelContactInput, options: cancel_contact.Options) !cancel_contact.CancelContactOutput {
        return cancel_contact.execute(self, allocator, input, options);
    }

    /// Creates a `Config` with the specified `configData` parameters.
    ///
    /// Only one type of `configData` can be specified.
    pub fn createConfig(self: *Self, allocator: std.mem.Allocator, input: create_config.CreateConfigInput, options: create_config.Options) !create_config.CreateConfigOutput {
        return create_config.execute(self, allocator, input, options);
    }

    /// Creates a `DataflowEndpoint` group containing the specified list of `
    /// DataflowEndpoint` objects.
    ///
    /// The `name` field in each endpoint is used in your mission profile `
    /// DataflowEndpointConfig` to specify which endpoints to use during a contact.
    ///
    /// When a contact uses multiple `DataflowEndpointConfig` objects, each `
    /// Config` must match a `DataflowEndpoint` in the same group.
    pub fn createDataflowEndpointGroup(self: *Self, allocator: std.mem.Allocator, input: create_dataflow_endpoint_group.CreateDataflowEndpointGroupInput, options: create_dataflow_endpoint_group.Options) !create_dataflow_endpoint_group.CreateDataflowEndpointGroupOutput {
        return create_dataflow_endpoint_group.execute(self, allocator, input, options);
    }

    /// Creates a `DataflowEndpoint` group containing the specified list of Ground
    /// Station Agent based endpoints.
    ///
    /// The `name` field in each endpoint is used in your mission profile `
    /// DataflowEndpointConfig` to specify which endpoints to use during a contact.
    ///
    /// When a contact uses multiple `DataflowEndpointConfig` objects, each `
    /// Config` must match a `DataflowEndpoint` in the same group.
    pub fn createDataflowEndpointGroupV2(self: *Self, allocator: std.mem.Allocator, input: create_dataflow_endpoint_group_v2.CreateDataflowEndpointGroupV2Input, options: create_dataflow_endpoint_group_v2.Options) !create_dataflow_endpoint_group_v2.CreateDataflowEndpointGroupV2Output {
        return create_dataflow_endpoint_group_v2.execute(self, allocator, input, options);
    }

    /// Create an ephemeris with your specified EphemerisData.
    pub fn createEphemeris(self: *Self, allocator: std.mem.Allocator, input: create_ephemeris.CreateEphemerisInput, options: create_ephemeris.Options) !create_ephemeris.CreateEphemerisOutput {
        return create_ephemeris.execute(self, allocator, input, options);
    }

    /// Creates a mission profile.
    ///
    /// `dataflowEdges` is a list of lists of strings. Each lower level list of
    /// strings has two elements: a *from* ARN and a *to* ARN.
    pub fn createMissionProfile(self: *Self, allocator: std.mem.Allocator, input: create_mission_profile.CreateMissionProfileInput, options: create_mission_profile.Options) !create_mission_profile.CreateMissionProfileOutput {
        return create_mission_profile.execute(self, allocator, input, options);
    }

    /// Deletes a `Config`.
    pub fn deleteConfig(self: *Self, allocator: std.mem.Allocator, input: delete_config.DeleteConfigInput, options: delete_config.Options) !delete_config.DeleteConfigOutput {
        return delete_config.execute(self, allocator, input, options);
    }

    /// Deletes a dataflow endpoint group.
    pub fn deleteDataflowEndpointGroup(self: *Self, allocator: std.mem.Allocator, input: delete_dataflow_endpoint_group.DeleteDataflowEndpointGroupInput, options: delete_dataflow_endpoint_group.Options) !delete_dataflow_endpoint_group.DeleteDataflowEndpointGroupOutput {
        return delete_dataflow_endpoint_group.execute(self, allocator, input, options);
    }

    /// Delete an ephemeris.
    pub fn deleteEphemeris(self: *Self, allocator: std.mem.Allocator, input: delete_ephemeris.DeleteEphemerisInput, options: delete_ephemeris.Options) !delete_ephemeris.DeleteEphemerisOutput {
        return delete_ephemeris.execute(self, allocator, input, options);
    }

    /// Deletes a mission profile.
    pub fn deleteMissionProfile(self: *Self, allocator: std.mem.Allocator, input: delete_mission_profile.DeleteMissionProfileInput, options: delete_mission_profile.Options) !delete_mission_profile.DeleteMissionProfileOutput {
        return delete_mission_profile.execute(self, allocator, input, options);
    }

    /// Describes an existing contact.
    pub fn describeContact(self: *Self, allocator: std.mem.Allocator, input: describe_contact.DescribeContactInput, options: describe_contact.Options) !describe_contact.DescribeContactOutput {
        return describe_contact.execute(self, allocator, input, options);
    }

    /// Retrieve information about an existing ephemeris.
    pub fn describeEphemeris(self: *Self, allocator: std.mem.Allocator, input: describe_ephemeris.DescribeEphemerisInput, options: describe_ephemeris.Options) !describe_ephemeris.DescribeEphemerisOutput {
        return describe_ephemeris.execute(self, allocator, input, options);
    }

    /// For use by AWS Ground Station Agent and shouldn't be called directly.
    ///
    /// Gets the latest configuration information for a registered agent.
    pub fn getAgentConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_agent_configuration.GetAgentConfigurationInput, options: get_agent_configuration.Options) !get_agent_configuration.GetAgentConfigurationOutput {
        return get_agent_configuration.execute(self, allocator, input, options);
    }

    /// For use by AWS Ground Station Agent and shouldn't be called directly.
    ///
    /// Gets a presigned URL for uploading agent task response logs.
    pub fn getAgentTaskResponseUrl(self: *Self, allocator: std.mem.Allocator, input: get_agent_task_response_url.GetAgentTaskResponseUrlInput, options: get_agent_task_response_url.Options) !get_agent_task_response_url.GetAgentTaskResponseUrlOutput {
        return get_agent_task_response_url.execute(self, allocator, input, options);
    }

    /// Returns `Config` information.
    ///
    /// Only one `Config` response can be returned.
    pub fn getConfig(self: *Self, allocator: std.mem.Allocator, input: get_config.GetConfigInput, options: get_config.Options) !get_config.GetConfigOutput {
        return get_config.execute(self, allocator, input, options);
    }

    /// Returns the dataflow endpoint group.
    pub fn getDataflowEndpointGroup(self: *Self, allocator: std.mem.Allocator, input: get_dataflow_endpoint_group.GetDataflowEndpointGroupInput, options: get_dataflow_endpoint_group.Options) !get_dataflow_endpoint_group.GetDataflowEndpointGroupOutput {
        return get_dataflow_endpoint_group.execute(self, allocator, input, options);
    }

    /// Returns the number of reserved minutes used by account.
    pub fn getMinuteUsage(self: *Self, allocator: std.mem.Allocator, input: get_minute_usage.GetMinuteUsageInput, options: get_minute_usage.Options) !get_minute_usage.GetMinuteUsageOutput {
        return get_minute_usage.execute(self, allocator, input, options);
    }

    /// Returns a mission profile.
    pub fn getMissionProfile(self: *Self, allocator: std.mem.Allocator, input: get_mission_profile.GetMissionProfileInput, options: get_mission_profile.Options) !get_mission_profile.GetMissionProfileOutput {
        return get_mission_profile.execute(self, allocator, input, options);
    }

    /// Returns a satellite.
    pub fn getSatellite(self: *Self, allocator: std.mem.Allocator, input: get_satellite.GetSatelliteInput, options: get_satellite.Options) !get_satellite.GetSatelliteOutput {
        return get_satellite.execute(self, allocator, input, options);
    }

    /// Returns a list of `Config` objects.
    pub fn listConfigs(self: *Self, allocator: std.mem.Allocator, input: list_configs.ListConfigsInput, options: list_configs.Options) !list_configs.ListConfigsOutput {
        return list_configs.execute(self, allocator, input, options);
    }

    /// Returns a list of contacts.
    ///
    /// If `statusList` contains AVAILABLE, the request must include `
    /// groundStation`, `missionprofileArn`, and `satelliteArn`.
    pub fn listContacts(self: *Self, allocator: std.mem.Allocator, input: list_contacts.ListContactsInput, options: list_contacts.Options) !list_contacts.ListContactsOutput {
        return list_contacts.execute(self, allocator, input, options);
    }

    /// Returns a list of `DataflowEndpoint` groups.
    pub fn listDataflowEndpointGroups(self: *Self, allocator: std.mem.Allocator, input: list_dataflow_endpoint_groups.ListDataflowEndpointGroupsInput, options: list_dataflow_endpoint_groups.Options) !list_dataflow_endpoint_groups.ListDataflowEndpointGroupsOutput {
        return list_dataflow_endpoint_groups.execute(self, allocator, input, options);
    }

    /// List your existing ephemerides.
    pub fn listEphemerides(self: *Self, allocator: std.mem.Allocator, input: list_ephemerides.ListEphemeridesInput, options: list_ephemerides.Options) !list_ephemerides.ListEphemeridesOutput {
        return list_ephemerides.execute(self, allocator, input, options);
    }

    /// Returns a list of ground stations.
    pub fn listGroundStations(self: *Self, allocator: std.mem.Allocator, input: list_ground_stations.ListGroundStationsInput, options: list_ground_stations.Options) !list_ground_stations.ListGroundStationsOutput {
        return list_ground_stations.execute(self, allocator, input, options);
    }

    /// Returns a list of mission profiles.
    pub fn listMissionProfiles(self: *Self, allocator: std.mem.Allocator, input: list_mission_profiles.ListMissionProfilesInput, options: list_mission_profiles.Options) !list_mission_profiles.ListMissionProfilesOutput {
        return list_mission_profiles.execute(self, allocator, input, options);
    }

    /// Returns a list of satellites.
    pub fn listSatellites(self: *Self, allocator: std.mem.Allocator, input: list_satellites.ListSatellitesInput, options: list_satellites.Options) !list_satellites.ListSatellitesOutput {
        return list_satellites.execute(self, allocator, input, options);
    }

    /// Returns a list of tags for a specified resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// For use by AWS Ground Station Agent and shouldn't be called directly.
    ///
    /// Registers a new agent with AWS Ground Station.
    pub fn registerAgent(self: *Self, allocator: std.mem.Allocator, input: register_agent.RegisterAgentInput, options: register_agent.Options) !register_agent.RegisterAgentOutput {
        return register_agent.execute(self, allocator, input, options);
    }

    /// Reserves a contact using specified parameters.
    pub fn reserveContact(self: *Self, allocator: std.mem.Allocator, input: reserve_contact.ReserveContactInput, options: reserve_contact.Options) !reserve_contact.ReserveContactOutput {
        return reserve_contact.execute(self, allocator, input, options);
    }

    /// Assigns a tag to a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Deassigns a resource tag.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// For use by AWS Ground Station Agent and shouldn't be called directly.
    ///
    /// Update the status of the agent.
    pub fn updateAgentStatus(self: *Self, allocator: std.mem.Allocator, input: update_agent_status.UpdateAgentStatusInput, options: update_agent_status.Options) !update_agent_status.UpdateAgentStatusOutput {
        return update_agent_status.execute(self, allocator, input, options);
    }

    /// Updates the `Config` used when scheduling contacts.
    ///
    /// Updating a `Config` will not update the execution parameters for existing
    /// future contacts scheduled with this `Config`.
    pub fn updateConfig(self: *Self, allocator: std.mem.Allocator, input: update_config.UpdateConfigInput, options: update_config.Options) !update_config.UpdateConfigOutput {
        return update_config.execute(self, allocator, input, options);
    }

    /// Update an existing ephemeris.
    pub fn updateEphemeris(self: *Self, allocator: std.mem.Allocator, input: update_ephemeris.UpdateEphemerisInput, options: update_ephemeris.Options) !update_ephemeris.UpdateEphemerisOutput {
        return update_ephemeris.execute(self, allocator, input, options);
    }

    /// Updates a mission profile.
    ///
    /// Updating a mission profile will not update the execution parameters for
    /// existing future contacts.
    pub fn updateMissionProfile(self: *Self, allocator: std.mem.Allocator, input: update_mission_profile.UpdateMissionProfileInput, options: update_mission_profile.Options) !update_mission_profile.UpdateMissionProfileOutput {
        return update_mission_profile.execute(self, allocator, input, options);
    }

    pub fn listConfigsPaginator(self: *Self, params: list_configs.ListConfigsInput) paginator.ListConfigsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listContactsPaginator(self: *Self, params: list_contacts.ListContactsInput) paginator.ListContactsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDataflowEndpointGroupsPaginator(self: *Self, params: list_dataflow_endpoint_groups.ListDataflowEndpointGroupsInput) paginator.ListDataflowEndpointGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEphemeridesPaginator(self: *Self, params: list_ephemerides.ListEphemeridesInput) paginator.ListEphemeridesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listGroundStationsPaginator(self: *Self, params: list_ground_stations.ListGroundStationsInput) paginator.ListGroundStationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMissionProfilesPaginator(self: *Self, params: list_mission_profiles.ListMissionProfilesInput) paginator.ListMissionProfilesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSatellitesPaginator(self: *Self, params: list_satellites.ListSatellitesInput) paginator.ListSatellitesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilContactScheduled(self: *Self, params: describe_contact.DescribeContactInput) aws.waiter.WaiterError!void {
        var w = waiters.ContactScheduledWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
