const aws = @import("aws");
const std = @import("std");

const accept_input_device_transfer = @import("accept_input_device_transfer.zig");
const batch_delete = @import("batch_delete.zig");
const batch_start = @import("batch_start.zig");
const batch_stop = @import("batch_stop.zig");
const batch_update_schedule = @import("batch_update_schedule.zig");
const cancel_input_device_transfer = @import("cancel_input_device_transfer.zig");
const claim_device = @import("claim_device.zig");
const create_channel = @import("create_channel.zig");
const create_channel_placement_group = @import("create_channel_placement_group.zig");
const create_cloud_watch_alarm_template = @import("create_cloud_watch_alarm_template.zig");
const create_cloud_watch_alarm_template_group = @import("create_cloud_watch_alarm_template_group.zig");
const create_cluster = @import("create_cluster.zig");
const create_event_bridge_rule_template = @import("create_event_bridge_rule_template.zig");
const create_event_bridge_rule_template_group = @import("create_event_bridge_rule_template_group.zig");
const create_input = @import("create_input.zig");
const create_input_security_group = @import("create_input_security_group.zig");
const create_multiplex = @import("create_multiplex.zig");
const create_multiplex_program = @import("create_multiplex_program.zig");
const create_network = @import("create_network.zig");
const create_node = @import("create_node.zig");
const create_node_registration_script = @import("create_node_registration_script.zig");
const create_partner_input = @import("create_partner_input.zig");
const create_sdi_source = @import("create_sdi_source.zig");
const create_signal_map = @import("create_signal_map.zig");
const create_tags = @import("create_tags.zig");
const delete_channel = @import("delete_channel.zig");
const delete_channel_placement_group = @import("delete_channel_placement_group.zig");
const delete_cloud_watch_alarm_template = @import("delete_cloud_watch_alarm_template.zig");
const delete_cloud_watch_alarm_template_group = @import("delete_cloud_watch_alarm_template_group.zig");
const delete_cluster = @import("delete_cluster.zig");
const delete_event_bridge_rule_template = @import("delete_event_bridge_rule_template.zig");
const delete_event_bridge_rule_template_group = @import("delete_event_bridge_rule_template_group.zig");
const delete_input = @import("delete_input.zig");
const delete_input_security_group = @import("delete_input_security_group.zig");
const delete_multiplex = @import("delete_multiplex.zig");
const delete_multiplex_program = @import("delete_multiplex_program.zig");
const delete_network = @import("delete_network.zig");
const delete_node = @import("delete_node.zig");
const delete_reservation = @import("delete_reservation.zig");
const delete_schedule = @import("delete_schedule.zig");
const delete_sdi_source = @import("delete_sdi_source.zig");
const delete_signal_map = @import("delete_signal_map.zig");
const delete_tags = @import("delete_tags.zig");
const describe_account_configuration = @import("describe_account_configuration.zig");
const describe_channel = @import("describe_channel.zig");
const describe_channel_placement_group = @import("describe_channel_placement_group.zig");
const describe_cluster = @import("describe_cluster.zig");
const describe_input = @import("describe_input.zig");
const describe_input_device = @import("describe_input_device.zig");
const describe_input_device_thumbnail = @import("describe_input_device_thumbnail.zig");
const describe_input_security_group = @import("describe_input_security_group.zig");
const describe_multiplex = @import("describe_multiplex.zig");
const describe_multiplex_program = @import("describe_multiplex_program.zig");
const describe_network = @import("describe_network.zig");
const describe_node = @import("describe_node.zig");
const describe_offering = @import("describe_offering.zig");
const describe_reservation = @import("describe_reservation.zig");
const describe_schedule = @import("describe_schedule.zig");
const describe_sdi_source = @import("describe_sdi_source.zig");
const describe_thumbnails = @import("describe_thumbnails.zig");
const get_cloud_watch_alarm_template = @import("get_cloud_watch_alarm_template.zig");
const get_cloud_watch_alarm_template_group = @import("get_cloud_watch_alarm_template_group.zig");
const get_event_bridge_rule_template = @import("get_event_bridge_rule_template.zig");
const get_event_bridge_rule_template_group = @import("get_event_bridge_rule_template_group.zig");
const get_signal_map = @import("get_signal_map.zig");
const list_alerts = @import("list_alerts.zig");
const list_channel_placement_groups = @import("list_channel_placement_groups.zig");
const list_channels = @import("list_channels.zig");
const list_cloud_watch_alarm_template_groups = @import("list_cloud_watch_alarm_template_groups.zig");
const list_cloud_watch_alarm_templates = @import("list_cloud_watch_alarm_templates.zig");
const list_cluster_alerts = @import("list_cluster_alerts.zig");
const list_clusters = @import("list_clusters.zig");
const list_event_bridge_rule_template_groups = @import("list_event_bridge_rule_template_groups.zig");
const list_event_bridge_rule_templates = @import("list_event_bridge_rule_templates.zig");
const list_input_device_transfers = @import("list_input_device_transfers.zig");
const list_input_devices = @import("list_input_devices.zig");
const list_input_security_groups = @import("list_input_security_groups.zig");
const list_inputs = @import("list_inputs.zig");
const list_multiplex_alerts = @import("list_multiplex_alerts.zig");
const list_multiplex_programs = @import("list_multiplex_programs.zig");
const list_multiplexes = @import("list_multiplexes.zig");
const list_networks = @import("list_networks.zig");
const list_nodes = @import("list_nodes.zig");
const list_offerings = @import("list_offerings.zig");
const list_reservations = @import("list_reservations.zig");
const list_sdi_sources = @import("list_sdi_sources.zig");
const list_signal_maps = @import("list_signal_maps.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_versions = @import("list_versions.zig");
const purchase_offering = @import("purchase_offering.zig");
const reboot_input_device = @import("reboot_input_device.zig");
const reject_input_device_transfer = @import("reject_input_device_transfer.zig");
const restart_channel_pipelines = @import("restart_channel_pipelines.zig");
const start_channel = @import("start_channel.zig");
const start_delete_monitor_deployment = @import("start_delete_monitor_deployment.zig");
const start_input_device = @import("start_input_device.zig");
const start_input_device_maintenance_window = @import("start_input_device_maintenance_window.zig");
const start_monitor_deployment = @import("start_monitor_deployment.zig");
const start_multiplex = @import("start_multiplex.zig");
const start_update_signal_map = @import("start_update_signal_map.zig");
const stop_channel = @import("stop_channel.zig");
const stop_input_device = @import("stop_input_device.zig");
const stop_multiplex = @import("stop_multiplex.zig");
const transfer_input_device = @import("transfer_input_device.zig");
const update_account_configuration = @import("update_account_configuration.zig");
const update_channel = @import("update_channel.zig");
const update_channel_class = @import("update_channel_class.zig");
const update_channel_placement_group = @import("update_channel_placement_group.zig");
const update_cloud_watch_alarm_template = @import("update_cloud_watch_alarm_template.zig");
const update_cloud_watch_alarm_template_group = @import("update_cloud_watch_alarm_template_group.zig");
const update_cluster = @import("update_cluster.zig");
const update_event_bridge_rule_template = @import("update_event_bridge_rule_template.zig");
const update_event_bridge_rule_template_group = @import("update_event_bridge_rule_template_group.zig");
const update_input = @import("update_input.zig");
const update_input_device = @import("update_input_device.zig");
const update_input_security_group = @import("update_input_security_group.zig");
const update_multiplex = @import("update_multiplex.zig");
const update_multiplex_program = @import("update_multiplex_program.zig");
const update_network = @import("update_network.zig");
const update_node = @import("update_node.zig");
const update_node_state = @import("update_node_state.zig");
const update_reservation = @import("update_reservation.zig");
const update_sdi_source = @import("update_sdi_source.zig");
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "MediaLive";

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

    /// Accept an incoming input device transfer. The ownership of the device will
    /// transfer to your AWS account.
    pub fn acceptInputDeviceTransfer(self: *Self, allocator: std.mem.Allocator, input: accept_input_device_transfer.AcceptInputDeviceTransferInput, options: accept_input_device_transfer.Options) !accept_input_device_transfer.AcceptInputDeviceTransferOutput {
        return accept_input_device_transfer.execute(self, allocator, input, options);
    }

    /// Starts delete of resources.
    pub fn batchDelete(self: *Self, allocator: std.mem.Allocator, input: batch_delete.BatchDeleteInput, options: batch_delete.Options) !batch_delete.BatchDeleteOutput {
        return batch_delete.execute(self, allocator, input, options);
    }

    /// Starts existing resources
    pub fn batchStart(self: *Self, allocator: std.mem.Allocator, input: batch_start.BatchStartInput, options: batch_start.Options) !batch_start.BatchStartOutput {
        return batch_start.execute(self, allocator, input, options);
    }

    /// Stops running resources
    pub fn batchStop(self: *Self, allocator: std.mem.Allocator, input: batch_stop.BatchStopInput, options: batch_stop.Options) !batch_stop.BatchStopOutput {
        return batch_stop.execute(self, allocator, input, options);
    }

    /// Update a channel schedule
    pub fn batchUpdateSchedule(self: *Self, allocator: std.mem.Allocator, input: batch_update_schedule.BatchUpdateScheduleInput, options: batch_update_schedule.Options) !batch_update_schedule.BatchUpdateScheduleOutput {
        return batch_update_schedule.execute(self, allocator, input, options);
    }

    /// Cancel an input device transfer that you have requested.
    pub fn cancelInputDeviceTransfer(self: *Self, allocator: std.mem.Allocator, input: cancel_input_device_transfer.CancelInputDeviceTransferInput, options: cancel_input_device_transfer.Options) !cancel_input_device_transfer.CancelInputDeviceTransferOutput {
        return cancel_input_device_transfer.execute(self, allocator, input, options);
    }

    /// Send a request to claim an AWS Elemental device that you have purchased from
    /// a third-party vendor. After the request succeeds, you will own the device.
    pub fn claimDevice(self: *Self, allocator: std.mem.Allocator, input: claim_device.ClaimDeviceInput, options: claim_device.Options) !claim_device.ClaimDeviceOutput {
        return claim_device.execute(self, allocator, input, options);
    }

    /// Creates a new channel
    pub fn createChannel(self: *Self, allocator: std.mem.Allocator, input: create_channel.CreateChannelInput, options: create_channel.Options) !create_channel.CreateChannelOutput {
        return create_channel.execute(self, allocator, input, options);
    }

    /// Create a ChannelPlacementGroup in the specified Cluster. As part of the
    /// create operation, you specify the Nodes to attach the group to.After you
    /// create a ChannelPlacementGroup, you add Channels to the group (you do this
    /// by modifying the Channels to add them to a specific group). You now have an
    /// association of Channels to ChannelPlacementGroup, and ChannelPlacementGroup
    /// to Nodes. This association means that all the Channels in the group are able
    /// to run on any of the Nodes associated with the group.
    pub fn createChannelPlacementGroup(self: *Self, allocator: std.mem.Allocator, input: create_channel_placement_group.CreateChannelPlacementGroupInput, options: create_channel_placement_group.Options) !create_channel_placement_group.CreateChannelPlacementGroupOutput {
        return create_channel_placement_group.execute(self, allocator, input, options);
    }

    /// Creates a cloudwatch alarm template to dynamically generate cloudwatch
    /// metric alarms on targeted resource types.
    pub fn createCloudWatchAlarmTemplate(self: *Self, allocator: std.mem.Allocator, input: create_cloud_watch_alarm_template.CreateCloudWatchAlarmTemplateInput, options: create_cloud_watch_alarm_template.Options) !create_cloud_watch_alarm_template.CreateCloudWatchAlarmTemplateOutput {
        return create_cloud_watch_alarm_template.execute(self, allocator, input, options);
    }

    /// Creates a cloudwatch alarm template group to group your cloudwatch alarm
    /// templates and to attach to signal maps for dynamically creating alarms.
    pub fn createCloudWatchAlarmTemplateGroup(self: *Self, allocator: std.mem.Allocator, input: create_cloud_watch_alarm_template_group.CreateCloudWatchAlarmTemplateGroupInput, options: create_cloud_watch_alarm_template_group.Options) !create_cloud_watch_alarm_template_group.CreateCloudWatchAlarmTemplateGroupOutput {
        return create_cloud_watch_alarm_template_group.execute(self, allocator, input, options);
    }

    /// Create a new Cluster.
    pub fn createCluster(self: *Self, allocator: std.mem.Allocator, input: create_cluster.CreateClusterInput, options: create_cluster.Options) !create_cluster.CreateClusterOutput {
        return create_cluster.execute(self, allocator, input, options);
    }

    /// Creates an eventbridge rule template to monitor events and send
    /// notifications to your targeted resources.
    pub fn createEventBridgeRuleTemplate(self: *Self, allocator: std.mem.Allocator, input: create_event_bridge_rule_template.CreateEventBridgeRuleTemplateInput, options: create_event_bridge_rule_template.Options) !create_event_bridge_rule_template.CreateEventBridgeRuleTemplateOutput {
        return create_event_bridge_rule_template.execute(self, allocator, input, options);
    }

    /// Creates an eventbridge rule template group to group your eventbridge rule
    /// templates and to attach to signal maps for dynamically creating notification
    /// rules.
    pub fn createEventBridgeRuleTemplateGroup(self: *Self, allocator: std.mem.Allocator, input: create_event_bridge_rule_template_group.CreateEventBridgeRuleTemplateGroupInput, options: create_event_bridge_rule_template_group.Options) !create_event_bridge_rule_template_group.CreateEventBridgeRuleTemplateGroupOutput {
        return create_event_bridge_rule_template_group.execute(self, allocator, input, options);
    }

    /// Create an input
    pub fn createInput(self: *Self, allocator: std.mem.Allocator, input: create_input.CreateInputInput, options: create_input.Options) !create_input.CreateInputOutput {
        return create_input.execute(self, allocator, input, options);
    }

    /// Creates a Input Security Group
    pub fn createInputSecurityGroup(self: *Self, allocator: std.mem.Allocator, input: create_input_security_group.CreateInputSecurityGroupInput, options: create_input_security_group.Options) !create_input_security_group.CreateInputSecurityGroupOutput {
        return create_input_security_group.execute(self, allocator, input, options);
    }

    /// Create a new multiplex.
    pub fn createMultiplex(self: *Self, allocator: std.mem.Allocator, input: create_multiplex.CreateMultiplexInput, options: create_multiplex.Options) !create_multiplex.CreateMultiplexOutput {
        return create_multiplex.execute(self, allocator, input, options);
    }

    /// Create a new program in the multiplex.
    pub fn createMultiplexProgram(self: *Self, allocator: std.mem.Allocator, input: create_multiplex_program.CreateMultiplexProgramInput, options: create_multiplex_program.Options) !create_multiplex_program.CreateMultiplexProgramOutput {
        return create_multiplex_program.execute(self, allocator, input, options);
    }

    /// Create as many Networks as you need. You will associate one or more Clusters
    /// with each Network.Each Network provides MediaLive Anywhere with required
    /// information about the network in your organization that you are using for
    /// video encoding using MediaLive.
    pub fn createNetwork(self: *Self, allocator: std.mem.Allocator, input: create_network.CreateNetworkInput, options: create_network.Options) !create_network.CreateNetworkOutput {
        return create_network.execute(self, allocator, input, options);
    }

    /// Create a Node in the specified Cluster. You can also create Nodes using the
    /// CreateNodeRegistrationScript. Note that you can't move a Node to another
    /// Cluster.
    pub fn createNode(self: *Self, allocator: std.mem.Allocator, input: create_node.CreateNodeInput, options: create_node.Options) !create_node.CreateNodeOutput {
        return create_node.execute(self, allocator, input, options);
    }

    /// Create the Register Node script for all the nodes intended for a specific
    /// Cluster. You will then run the script on each hardware unit that is intended
    /// for that Cluster. The script creates a Node in the specified Cluster. It
    /// then binds the Node to this hardware unit, and activates the node hardware
    /// for use with MediaLive Anywhere.
    pub fn createNodeRegistrationScript(self: *Self, allocator: std.mem.Allocator, input: create_node_registration_script.CreateNodeRegistrationScriptInput, options: create_node_registration_script.Options) !create_node_registration_script.CreateNodeRegistrationScriptOutput {
        return create_node_registration_script.execute(self, allocator, input, options);
    }

    /// Create a partner input
    pub fn createPartnerInput(self: *Self, allocator: std.mem.Allocator, input: create_partner_input.CreatePartnerInputInput, options: create_partner_input.Options) !create_partner_input.CreatePartnerInputOutput {
        return create_partner_input.execute(self, allocator, input, options);
    }

    /// Create an SdiSource for each video source that uses the SDI protocol. You
    /// will reference the SdiSource when you create an SDI input in MediaLive. You
    /// will also reference it in an SdiSourceMapping, in order to create a
    /// connection between the logical SdiSource and the physical SDI card and port
    /// that the physical SDI source uses.
    pub fn createSdiSource(self: *Self, allocator: std.mem.Allocator, input: create_sdi_source.CreateSdiSourceInput, options: create_sdi_source.Options) !create_sdi_source.CreateSdiSourceOutput {
        return create_sdi_source.execute(self, allocator, input, options);
    }

    /// Initiates the creation of a new signal map. Will discover a new
    /// mediaResourceMap based on the provided discoveryEntryPointArn.
    pub fn createSignalMap(self: *Self, allocator: std.mem.Allocator, input: create_signal_map.CreateSignalMapInput, options: create_signal_map.Options) !create_signal_map.CreateSignalMapOutput {
        return create_signal_map.execute(self, allocator, input, options);
    }

    /// Create tags for a resource
    pub fn createTags(self: *Self, allocator: std.mem.Allocator, input: create_tags.CreateTagsInput, options: create_tags.Options) !create_tags.CreateTagsOutput {
        return create_tags.execute(self, allocator, input, options);
    }

    /// Starts deletion of channel. The associated outputs are also deleted.
    pub fn deleteChannel(self: *Self, allocator: std.mem.Allocator, input: delete_channel.DeleteChannelInput, options: delete_channel.Options) !delete_channel.DeleteChannelOutput {
        return delete_channel.execute(self, allocator, input, options);
    }

    /// Delete the specified ChannelPlacementGroup that exists in the specified
    /// Cluster.
    pub fn deleteChannelPlacementGroup(self: *Self, allocator: std.mem.Allocator, input: delete_channel_placement_group.DeleteChannelPlacementGroupInput, options: delete_channel_placement_group.Options) !delete_channel_placement_group.DeleteChannelPlacementGroupOutput {
        return delete_channel_placement_group.execute(self, allocator, input, options);
    }

    /// Deletes a cloudwatch alarm template.
    pub fn deleteCloudWatchAlarmTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_cloud_watch_alarm_template.DeleteCloudWatchAlarmTemplateInput, options: delete_cloud_watch_alarm_template.Options) !delete_cloud_watch_alarm_template.DeleteCloudWatchAlarmTemplateOutput {
        return delete_cloud_watch_alarm_template.execute(self, allocator, input, options);
    }

    /// Deletes a cloudwatch alarm template group. You must detach this group from
    /// all signal maps and ensure its existing templates are moved to another group
    /// or deleted.
    pub fn deleteCloudWatchAlarmTemplateGroup(self: *Self, allocator: std.mem.Allocator, input: delete_cloud_watch_alarm_template_group.DeleteCloudWatchAlarmTemplateGroupInput, options: delete_cloud_watch_alarm_template_group.Options) !delete_cloud_watch_alarm_template_group.DeleteCloudWatchAlarmTemplateGroupOutput {
        return delete_cloud_watch_alarm_template_group.execute(self, allocator, input, options);
    }

    /// Delete a Cluster. The Cluster must be idle.
    pub fn deleteCluster(self: *Self, allocator: std.mem.Allocator, input: delete_cluster.DeleteClusterInput, options: delete_cluster.Options) !delete_cluster.DeleteClusterOutput {
        return delete_cluster.execute(self, allocator, input, options);
    }

    /// Deletes an eventbridge rule template.
    pub fn deleteEventBridgeRuleTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_event_bridge_rule_template.DeleteEventBridgeRuleTemplateInput, options: delete_event_bridge_rule_template.Options) !delete_event_bridge_rule_template.DeleteEventBridgeRuleTemplateOutput {
        return delete_event_bridge_rule_template.execute(self, allocator, input, options);
    }

    /// Deletes an eventbridge rule template group. You must detach this group from
    /// all signal maps and ensure its existing templates are moved to another group
    /// or deleted.
    pub fn deleteEventBridgeRuleTemplateGroup(self: *Self, allocator: std.mem.Allocator, input: delete_event_bridge_rule_template_group.DeleteEventBridgeRuleTemplateGroupInput, options: delete_event_bridge_rule_template_group.Options) !delete_event_bridge_rule_template_group.DeleteEventBridgeRuleTemplateGroupOutput {
        return delete_event_bridge_rule_template_group.execute(self, allocator, input, options);
    }

    /// Deletes the input end point
    pub fn deleteInput(self: *Self, allocator: std.mem.Allocator, input: delete_input.DeleteInputInput, options: delete_input.Options) !delete_input.DeleteInputOutput {
        return delete_input.execute(self, allocator, input, options);
    }

    /// Deletes an Input Security Group
    pub fn deleteInputSecurityGroup(self: *Self, allocator: std.mem.Allocator, input: delete_input_security_group.DeleteInputSecurityGroupInput, options: delete_input_security_group.Options) !delete_input_security_group.DeleteInputSecurityGroupOutput {
        return delete_input_security_group.execute(self, allocator, input, options);
    }

    /// Delete a multiplex. The multiplex must be idle.
    pub fn deleteMultiplex(self: *Self, allocator: std.mem.Allocator, input: delete_multiplex.DeleteMultiplexInput, options: delete_multiplex.Options) !delete_multiplex.DeleteMultiplexOutput {
        return delete_multiplex.execute(self, allocator, input, options);
    }

    /// Delete a program from a multiplex.
    pub fn deleteMultiplexProgram(self: *Self, allocator: std.mem.Allocator, input: delete_multiplex_program.DeleteMultiplexProgramInput, options: delete_multiplex_program.Options) !delete_multiplex_program.DeleteMultiplexProgramOutput {
        return delete_multiplex_program.execute(self, allocator, input, options);
    }

    /// Delete a Network. The Network must have no resources associated with it.
    pub fn deleteNetwork(self: *Self, allocator: std.mem.Allocator, input: delete_network.DeleteNetworkInput, options: delete_network.Options) !delete_network.DeleteNetworkOutput {
        return delete_network.execute(self, allocator, input, options);
    }

    /// Delete a Node. The Node must be IDLE.
    pub fn deleteNode(self: *Self, allocator: std.mem.Allocator, input: delete_node.DeleteNodeInput, options: delete_node.Options) !delete_node.DeleteNodeOutput {
        return delete_node.execute(self, allocator, input, options);
    }

    /// Delete an expired reservation.
    pub fn deleteReservation(self: *Self, allocator: std.mem.Allocator, input: delete_reservation.DeleteReservationInput, options: delete_reservation.Options) !delete_reservation.DeleteReservationOutput {
        return delete_reservation.execute(self, allocator, input, options);
    }

    /// Delete all schedule actions on a channel.
    pub fn deleteSchedule(self: *Self, allocator: std.mem.Allocator, input: delete_schedule.DeleteScheduleInput, options: delete_schedule.Options) !delete_schedule.DeleteScheduleOutput {
        return delete_schedule.execute(self, allocator, input, options);
    }

    /// Delete an SdiSource. The SdiSource must not be part of any SidSourceMapping
    /// and must not be attached to any input.
    pub fn deleteSdiSource(self: *Self, allocator: std.mem.Allocator, input: delete_sdi_source.DeleteSdiSourceInput, options: delete_sdi_source.Options) !delete_sdi_source.DeleteSdiSourceOutput {
        return delete_sdi_source.execute(self, allocator, input, options);
    }

    /// Deletes the specified signal map.
    pub fn deleteSignalMap(self: *Self, allocator: std.mem.Allocator, input: delete_signal_map.DeleteSignalMapInput, options: delete_signal_map.Options) !delete_signal_map.DeleteSignalMapOutput {
        return delete_signal_map.execute(self, allocator, input, options);
    }

    /// Removes tags for a resource
    pub fn deleteTags(self: *Self, allocator: std.mem.Allocator, input: delete_tags.DeleteTagsInput, options: delete_tags.Options) !delete_tags.DeleteTagsOutput {
        return delete_tags.execute(self, allocator, input, options);
    }

    /// Describe account configuration
    pub fn describeAccountConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_account_configuration.DescribeAccountConfigurationInput, options: describe_account_configuration.Options) !describe_account_configuration.DescribeAccountConfigurationOutput {
        return describe_account_configuration.execute(self, allocator, input, options);
    }

    /// Gets details about a channel
    pub fn describeChannel(self: *Self, allocator: std.mem.Allocator, input: describe_channel.DescribeChannelInput, options: describe_channel.Options) !describe_channel.DescribeChannelOutput {
        return describe_channel.execute(self, allocator, input, options);
    }

    /// Get details about a ChannelPlacementGroup.
    pub fn describeChannelPlacementGroup(self: *Self, allocator: std.mem.Allocator, input: describe_channel_placement_group.DescribeChannelPlacementGroupInput, options: describe_channel_placement_group.Options) !describe_channel_placement_group.DescribeChannelPlacementGroupOutput {
        return describe_channel_placement_group.execute(self, allocator, input, options);
    }

    /// Get details about a Cluster.
    pub fn describeCluster(self: *Self, allocator: std.mem.Allocator, input: describe_cluster.DescribeClusterInput, options: describe_cluster.Options) !describe_cluster.DescribeClusterOutput {
        return describe_cluster.execute(self, allocator, input, options);
    }

    /// Produces details about an input
    pub fn describeInput(self: *Self, allocator: std.mem.Allocator, input: describe_input.DescribeInputInput, options: describe_input.Options) !describe_input.DescribeInputOutput {
        return describe_input.execute(self, allocator, input, options);
    }

    /// Gets the details for the input device
    pub fn describeInputDevice(self: *Self, allocator: std.mem.Allocator, input: describe_input_device.DescribeInputDeviceInput, options: describe_input_device.Options) !describe_input_device.DescribeInputDeviceOutput {
        return describe_input_device.execute(self, allocator, input, options);
    }

    /// Get the latest thumbnail data for the input device.
    pub fn describeInputDeviceThumbnail(self: *Self, allocator: std.mem.Allocator, input: describe_input_device_thumbnail.DescribeInputDeviceThumbnailInput, options: describe_input_device_thumbnail.Options) !describe_input_device_thumbnail.DescribeInputDeviceThumbnailOutput {
        return describe_input_device_thumbnail.execute(self, allocator, input, options);
    }

    /// Produces a summary of an Input Security Group
    pub fn describeInputSecurityGroup(self: *Self, allocator: std.mem.Allocator, input: describe_input_security_group.DescribeInputSecurityGroupInput, options: describe_input_security_group.Options) !describe_input_security_group.DescribeInputSecurityGroupOutput {
        return describe_input_security_group.execute(self, allocator, input, options);
    }

    /// Gets details about a multiplex.
    pub fn describeMultiplex(self: *Self, allocator: std.mem.Allocator, input: describe_multiplex.DescribeMultiplexInput, options: describe_multiplex.Options) !describe_multiplex.DescribeMultiplexOutput {
        return describe_multiplex.execute(self, allocator, input, options);
    }

    /// Get the details for a program in a multiplex.
    pub fn describeMultiplexProgram(self: *Self, allocator: std.mem.Allocator, input: describe_multiplex_program.DescribeMultiplexProgramInput, options: describe_multiplex_program.Options) !describe_multiplex_program.DescribeMultiplexProgramOutput {
        return describe_multiplex_program.execute(self, allocator, input, options);
    }

    /// Get details about a Network.
    pub fn describeNetwork(self: *Self, allocator: std.mem.Allocator, input: describe_network.DescribeNetworkInput, options: describe_network.Options) !describe_network.DescribeNetworkOutput {
        return describe_network.execute(self, allocator, input, options);
    }

    /// Get details about a Node in the specified Cluster.
    pub fn describeNode(self: *Self, allocator: std.mem.Allocator, input: describe_node.DescribeNodeInput, options: describe_node.Options) !describe_node.DescribeNodeOutput {
        return describe_node.execute(self, allocator, input, options);
    }

    /// Get details for an offering.
    pub fn describeOffering(self: *Self, allocator: std.mem.Allocator, input: describe_offering.DescribeOfferingInput, options: describe_offering.Options) !describe_offering.DescribeOfferingOutput {
        return describe_offering.execute(self, allocator, input, options);
    }

    /// Get details for a reservation.
    pub fn describeReservation(self: *Self, allocator: std.mem.Allocator, input: describe_reservation.DescribeReservationInput, options: describe_reservation.Options) !describe_reservation.DescribeReservationOutput {
        return describe_reservation.execute(self, allocator, input, options);
    }

    /// Get a channel schedule
    pub fn describeSchedule(self: *Self, allocator: std.mem.Allocator, input: describe_schedule.DescribeScheduleInput, options: describe_schedule.Options) !describe_schedule.DescribeScheduleOutput {
        return describe_schedule.execute(self, allocator, input, options);
    }

    /// Gets details about a SdiSource.
    pub fn describeSdiSource(self: *Self, allocator: std.mem.Allocator, input: describe_sdi_source.DescribeSdiSourceInput, options: describe_sdi_source.Options) !describe_sdi_source.DescribeSdiSourceOutput {
        return describe_sdi_source.execute(self, allocator, input, options);
    }

    /// Describe the latest thumbnails data.
    pub fn describeThumbnails(self: *Self, allocator: std.mem.Allocator, input: describe_thumbnails.DescribeThumbnailsInput, options: describe_thumbnails.Options) !describe_thumbnails.DescribeThumbnailsOutput {
        return describe_thumbnails.execute(self, allocator, input, options);
    }

    /// Retrieves the specified cloudwatch alarm template.
    pub fn getCloudWatchAlarmTemplate(self: *Self, allocator: std.mem.Allocator, input: get_cloud_watch_alarm_template.GetCloudWatchAlarmTemplateInput, options: get_cloud_watch_alarm_template.Options) !get_cloud_watch_alarm_template.GetCloudWatchAlarmTemplateOutput {
        return get_cloud_watch_alarm_template.execute(self, allocator, input, options);
    }

    /// Retrieves the specified cloudwatch alarm template group.
    pub fn getCloudWatchAlarmTemplateGroup(self: *Self, allocator: std.mem.Allocator, input: get_cloud_watch_alarm_template_group.GetCloudWatchAlarmTemplateGroupInput, options: get_cloud_watch_alarm_template_group.Options) !get_cloud_watch_alarm_template_group.GetCloudWatchAlarmTemplateGroupOutput {
        return get_cloud_watch_alarm_template_group.execute(self, allocator, input, options);
    }

    /// Retrieves the specified eventbridge rule template.
    pub fn getEventBridgeRuleTemplate(self: *Self, allocator: std.mem.Allocator, input: get_event_bridge_rule_template.GetEventBridgeRuleTemplateInput, options: get_event_bridge_rule_template.Options) !get_event_bridge_rule_template.GetEventBridgeRuleTemplateOutput {
        return get_event_bridge_rule_template.execute(self, allocator, input, options);
    }

    /// Retrieves the specified eventbridge rule template group.
    pub fn getEventBridgeRuleTemplateGroup(self: *Self, allocator: std.mem.Allocator, input: get_event_bridge_rule_template_group.GetEventBridgeRuleTemplateGroupInput, options: get_event_bridge_rule_template_group.Options) !get_event_bridge_rule_template_group.GetEventBridgeRuleTemplateGroupOutput {
        return get_event_bridge_rule_template_group.execute(self, allocator, input, options);
    }

    /// Retrieves the specified signal map.
    pub fn getSignalMap(self: *Self, allocator: std.mem.Allocator, input: get_signal_map.GetSignalMapInput, options: get_signal_map.Options) !get_signal_map.GetSignalMapOutput {
        return get_signal_map.execute(self, allocator, input, options);
    }

    /// List the alerts for a channel with optional filtering based on alert state.
    pub fn listAlerts(self: *Self, allocator: std.mem.Allocator, input: list_alerts.ListAlertsInput, options: list_alerts.Options) !list_alerts.ListAlertsOutput {
        return list_alerts.execute(self, allocator, input, options);
    }

    /// Retrieve the list of ChannelPlacementGroups in the specified Cluster.
    pub fn listChannelPlacementGroups(self: *Self, allocator: std.mem.Allocator, input: list_channel_placement_groups.ListChannelPlacementGroupsInput, options: list_channel_placement_groups.Options) !list_channel_placement_groups.ListChannelPlacementGroupsOutput {
        return list_channel_placement_groups.execute(self, allocator, input, options);
    }

    /// Produces list of channels that have been created
    pub fn listChannels(self: *Self, allocator: std.mem.Allocator, input: list_channels.ListChannelsInput, options: list_channels.Options) !list_channels.ListChannelsOutput {
        return list_channels.execute(self, allocator, input, options);
    }

    /// Lists cloudwatch alarm template groups.
    pub fn listCloudWatchAlarmTemplateGroups(self: *Self, allocator: std.mem.Allocator, input: list_cloud_watch_alarm_template_groups.ListCloudWatchAlarmTemplateGroupsInput, options: list_cloud_watch_alarm_template_groups.Options) !list_cloud_watch_alarm_template_groups.ListCloudWatchAlarmTemplateGroupsOutput {
        return list_cloud_watch_alarm_template_groups.execute(self, allocator, input, options);
    }

    /// Lists cloudwatch alarm templates.
    pub fn listCloudWatchAlarmTemplates(self: *Self, allocator: std.mem.Allocator, input: list_cloud_watch_alarm_templates.ListCloudWatchAlarmTemplatesInput, options: list_cloud_watch_alarm_templates.Options) !list_cloud_watch_alarm_templates.ListCloudWatchAlarmTemplatesOutput {
        return list_cloud_watch_alarm_templates.execute(self, allocator, input, options);
    }

    /// List the alerts for a cluster with optional filtering based on alert state.
    pub fn listClusterAlerts(self: *Self, allocator: std.mem.Allocator, input: list_cluster_alerts.ListClusterAlertsInput, options: list_cluster_alerts.Options) !list_cluster_alerts.ListClusterAlertsOutput {
        return list_cluster_alerts.execute(self, allocator, input, options);
    }

    /// Retrieve the list of Clusters.
    pub fn listClusters(self: *Self, allocator: std.mem.Allocator, input: list_clusters.ListClustersInput, options: list_clusters.Options) !list_clusters.ListClustersOutput {
        return list_clusters.execute(self, allocator, input, options);
    }

    /// Lists eventbridge rule template groups.
    pub fn listEventBridgeRuleTemplateGroups(self: *Self, allocator: std.mem.Allocator, input: list_event_bridge_rule_template_groups.ListEventBridgeRuleTemplateGroupsInput, options: list_event_bridge_rule_template_groups.Options) !list_event_bridge_rule_template_groups.ListEventBridgeRuleTemplateGroupsOutput {
        return list_event_bridge_rule_template_groups.execute(self, allocator, input, options);
    }

    /// Lists eventbridge rule templates.
    pub fn listEventBridgeRuleTemplates(self: *Self, allocator: std.mem.Allocator, input: list_event_bridge_rule_templates.ListEventBridgeRuleTemplatesInput, options: list_event_bridge_rule_templates.Options) !list_event_bridge_rule_templates.ListEventBridgeRuleTemplatesOutput {
        return list_event_bridge_rule_templates.execute(self, allocator, input, options);
    }

    /// List input devices that are currently being transferred. List input devices
    /// that you are transferring from your AWS account or input devices that
    /// another AWS account is transferring to you.
    pub fn listInputDeviceTransfers(self: *Self, allocator: std.mem.Allocator, input: list_input_device_transfers.ListInputDeviceTransfersInput, options: list_input_device_transfers.Options) !list_input_device_transfers.ListInputDeviceTransfersOutput {
        return list_input_device_transfers.execute(self, allocator, input, options);
    }

    /// List input devices
    pub fn listInputDevices(self: *Self, allocator: std.mem.Allocator, input: list_input_devices.ListInputDevicesInput, options: list_input_devices.Options) !list_input_devices.ListInputDevicesOutput {
        return list_input_devices.execute(self, allocator, input, options);
    }

    /// Produces a list of Input Security Groups for an account
    pub fn listInputSecurityGroups(self: *Self, allocator: std.mem.Allocator, input: list_input_security_groups.ListInputSecurityGroupsInput, options: list_input_security_groups.Options) !list_input_security_groups.ListInputSecurityGroupsOutput {
        return list_input_security_groups.execute(self, allocator, input, options);
    }

    /// Produces list of inputs that have been created
    pub fn listInputs(self: *Self, allocator: std.mem.Allocator, input: list_inputs.ListInputsInput, options: list_inputs.Options) !list_inputs.ListInputsOutput {
        return list_inputs.execute(self, allocator, input, options);
    }

    /// List the alerts for a multiplex with optional filtering based on alert
    /// state.
    pub fn listMultiplexAlerts(self: *Self, allocator: std.mem.Allocator, input: list_multiplex_alerts.ListMultiplexAlertsInput, options: list_multiplex_alerts.Options) !list_multiplex_alerts.ListMultiplexAlertsOutput {
        return list_multiplex_alerts.execute(self, allocator, input, options);
    }

    /// List the programs that currently exist for a specific multiplex.
    pub fn listMultiplexPrograms(self: *Self, allocator: std.mem.Allocator, input: list_multiplex_programs.ListMultiplexProgramsInput, options: list_multiplex_programs.Options) !list_multiplex_programs.ListMultiplexProgramsOutput {
        return list_multiplex_programs.execute(self, allocator, input, options);
    }

    /// Retrieve a list of the existing multiplexes.
    pub fn listMultiplexes(self: *Self, allocator: std.mem.Allocator, input: list_multiplexes.ListMultiplexesInput, options: list_multiplexes.Options) !list_multiplexes.ListMultiplexesOutput {
        return list_multiplexes.execute(self, allocator, input, options);
    }

    /// Retrieve the list of Networks.
    pub fn listNetworks(self: *Self, allocator: std.mem.Allocator, input: list_networks.ListNetworksInput, options: list_networks.Options) !list_networks.ListNetworksOutput {
        return list_networks.execute(self, allocator, input, options);
    }

    /// Retrieve the list of Nodes.
    pub fn listNodes(self: *Self, allocator: std.mem.Allocator, input: list_nodes.ListNodesInput, options: list_nodes.Options) !list_nodes.ListNodesOutput {
        return list_nodes.execute(self, allocator, input, options);
    }

    /// List offerings available for purchase.
    pub fn listOfferings(self: *Self, allocator: std.mem.Allocator, input: list_offerings.ListOfferingsInput, options: list_offerings.Options) !list_offerings.ListOfferingsOutput {
        return list_offerings.execute(self, allocator, input, options);
    }

    /// List purchased reservations.
    pub fn listReservations(self: *Self, allocator: std.mem.Allocator, input: list_reservations.ListReservationsInput, options: list_reservations.Options) !list_reservations.ListReservationsOutput {
        return list_reservations.execute(self, allocator, input, options);
    }

    /// List all the SdiSources in the AWS account.
    pub fn listSdiSources(self: *Self, allocator: std.mem.Allocator, input: list_sdi_sources.ListSdiSourcesInput, options: list_sdi_sources.Options) !list_sdi_sources.ListSdiSourcesOutput {
        return list_sdi_sources.execute(self, allocator, input, options);
    }

    /// Lists signal maps.
    pub fn listSignalMaps(self: *Self, allocator: std.mem.Allocator, input: list_signal_maps.ListSignalMapsInput, options: list_signal_maps.Options) !list_signal_maps.ListSignalMapsOutput {
        return list_signal_maps.execute(self, allocator, input, options);
    }

    /// Produces list of tags that have been created for a resource
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Retrieves an array of all the encoder engine versions that are available in
    /// this AWS account.
    pub fn listVersions(self: *Self, allocator: std.mem.Allocator, input: list_versions.ListVersionsInput, options: list_versions.Options) !list_versions.ListVersionsOutput {
        return list_versions.execute(self, allocator, input, options);
    }

    /// Purchase an offering and create a reservation.
    pub fn purchaseOffering(self: *Self, allocator: std.mem.Allocator, input: purchase_offering.PurchaseOfferingInput, options: purchase_offering.Options) !purchase_offering.PurchaseOfferingOutput {
        return purchase_offering.execute(self, allocator, input, options);
    }

    /// Send a reboot command to the specified input device. The device will begin
    /// rebooting within a few seconds of sending the command. When the reboot is
    /// complete, the device’s connection status will change to connected.
    pub fn rebootInputDevice(self: *Self, allocator: std.mem.Allocator, input: reboot_input_device.RebootInputDeviceInput, options: reboot_input_device.Options) !reboot_input_device.RebootInputDeviceOutput {
        return reboot_input_device.execute(self, allocator, input, options);
    }

    /// Reject the transfer of the specified input device to your AWS account.
    pub fn rejectInputDeviceTransfer(self: *Self, allocator: std.mem.Allocator, input: reject_input_device_transfer.RejectInputDeviceTransferInput, options: reject_input_device_transfer.Options) !reject_input_device_transfer.RejectInputDeviceTransferOutput {
        return reject_input_device_transfer.execute(self, allocator, input, options);
    }

    /// Restart pipelines in one channel that is currently running.
    pub fn restartChannelPipelines(self: *Self, allocator: std.mem.Allocator, input: restart_channel_pipelines.RestartChannelPipelinesInput, options: restart_channel_pipelines.Options) !restart_channel_pipelines.RestartChannelPipelinesOutput {
        return restart_channel_pipelines.execute(self, allocator, input, options);
    }

    /// Starts an existing channel
    pub fn startChannel(self: *Self, allocator: std.mem.Allocator, input: start_channel.StartChannelInput, options: start_channel.Options) !start_channel.StartChannelOutput {
        return start_channel.execute(self, allocator, input, options);
    }

    /// Initiates a deployment to delete the monitor of the specified signal map.
    pub fn startDeleteMonitorDeployment(self: *Self, allocator: std.mem.Allocator, input: start_delete_monitor_deployment.StartDeleteMonitorDeploymentInput, options: start_delete_monitor_deployment.Options) !start_delete_monitor_deployment.StartDeleteMonitorDeploymentOutput {
        return start_delete_monitor_deployment.execute(self, allocator, input, options);
    }

    /// Start an input device that is attached to a MediaConnect flow. (There is no
    /// need to start a device that is attached to a MediaLive input; MediaLive
    /// starts the device when the channel starts.)
    pub fn startInputDevice(self: *Self, allocator: std.mem.Allocator, input: start_input_device.StartInputDeviceInput, options: start_input_device.Options) !start_input_device.StartInputDeviceOutput {
        return start_input_device.execute(self, allocator, input, options);
    }

    /// Start a maintenance window for the specified input device. Starting a
    /// maintenance window will give the device up to two hours to install software.
    /// If the device was streaming prior to the maintenance, it will resume
    /// streaming when the software is fully installed. Devices automatically
    /// install updates while they are powered on and their MediaLive channels are
    /// stopped. A maintenance window allows you to update a device without having
    /// to stop MediaLive channels that use the device. The device must remain
    /// powered on and connected to the internet for the duration of the
    /// maintenance.
    pub fn startInputDeviceMaintenanceWindow(self: *Self, allocator: std.mem.Allocator, input: start_input_device_maintenance_window.StartInputDeviceMaintenanceWindowInput, options: start_input_device_maintenance_window.Options) !start_input_device_maintenance_window.StartInputDeviceMaintenanceWindowOutput {
        return start_input_device_maintenance_window.execute(self, allocator, input, options);
    }

    /// Initiates a deployment to deploy the latest monitor of the specified signal
    /// map.
    pub fn startMonitorDeployment(self: *Self, allocator: std.mem.Allocator, input: start_monitor_deployment.StartMonitorDeploymentInput, options: start_monitor_deployment.Options) !start_monitor_deployment.StartMonitorDeploymentOutput {
        return start_monitor_deployment.execute(self, allocator, input, options);
    }

    /// Start (run) the multiplex. Starting the multiplex does not start the
    /// channels. You must explicitly start each channel.
    pub fn startMultiplex(self: *Self, allocator: std.mem.Allocator, input: start_multiplex.StartMultiplexInput, options: start_multiplex.Options) !start_multiplex.StartMultiplexOutput {
        return start_multiplex.execute(self, allocator, input, options);
    }

    /// Initiates an update for the specified signal map. Will discover a new signal
    /// map if a changed discoveryEntryPointArn is provided.
    pub fn startUpdateSignalMap(self: *Self, allocator: std.mem.Allocator, input: start_update_signal_map.StartUpdateSignalMapInput, options: start_update_signal_map.Options) !start_update_signal_map.StartUpdateSignalMapOutput {
        return start_update_signal_map.execute(self, allocator, input, options);
    }

    /// Stops a running channel
    pub fn stopChannel(self: *Self, allocator: std.mem.Allocator, input: stop_channel.StopChannelInput, options: stop_channel.Options) !stop_channel.StopChannelOutput {
        return stop_channel.execute(self, allocator, input, options);
    }

    /// Stop an input device that is attached to a MediaConnect flow. (There is no
    /// need to stop a device that is attached to a MediaLive input; MediaLive
    /// automatically stops the device when the channel stops.)
    pub fn stopInputDevice(self: *Self, allocator: std.mem.Allocator, input: stop_input_device.StopInputDeviceInput, options: stop_input_device.Options) !stop_input_device.StopInputDeviceOutput {
        return stop_input_device.execute(self, allocator, input, options);
    }

    /// Stops a running multiplex. If the multiplex isn't running, this action has
    /// no effect.
    pub fn stopMultiplex(self: *Self, allocator: std.mem.Allocator, input: stop_multiplex.StopMultiplexInput, options: stop_multiplex.Options) !stop_multiplex.StopMultiplexOutput {
        return stop_multiplex.execute(self, allocator, input, options);
    }

    /// Start an input device transfer to another AWS account. After you make the
    /// request, the other account must accept or reject the transfer.
    pub fn transferInputDevice(self: *Self, allocator: std.mem.Allocator, input: transfer_input_device.TransferInputDeviceInput, options: transfer_input_device.Options) !transfer_input_device.TransferInputDeviceOutput {
        return transfer_input_device.execute(self, allocator, input, options);
    }

    /// Update account configuration
    pub fn updateAccountConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_account_configuration.UpdateAccountConfigurationInput, options: update_account_configuration.Options) !update_account_configuration.UpdateAccountConfigurationOutput {
        return update_account_configuration.execute(self, allocator, input, options);
    }

    /// Updates a channel.
    pub fn updateChannel(self: *Self, allocator: std.mem.Allocator, input: update_channel.UpdateChannelInput, options: update_channel.Options) !update_channel.UpdateChannelOutput {
        return update_channel.execute(self, allocator, input, options);
    }

    /// Changes the class of the channel.
    pub fn updateChannelClass(self: *Self, allocator: std.mem.Allocator, input: update_channel_class.UpdateChannelClassInput, options: update_channel_class.Options) !update_channel_class.UpdateChannelClassOutput {
        return update_channel_class.execute(self, allocator, input, options);
    }

    /// Change the settings for a ChannelPlacementGroup.
    pub fn updateChannelPlacementGroup(self: *Self, allocator: std.mem.Allocator, input: update_channel_placement_group.UpdateChannelPlacementGroupInput, options: update_channel_placement_group.Options) !update_channel_placement_group.UpdateChannelPlacementGroupOutput {
        return update_channel_placement_group.execute(self, allocator, input, options);
    }

    /// Updates the specified cloudwatch alarm template.
    pub fn updateCloudWatchAlarmTemplate(self: *Self, allocator: std.mem.Allocator, input: update_cloud_watch_alarm_template.UpdateCloudWatchAlarmTemplateInput, options: update_cloud_watch_alarm_template.Options) !update_cloud_watch_alarm_template.UpdateCloudWatchAlarmTemplateOutput {
        return update_cloud_watch_alarm_template.execute(self, allocator, input, options);
    }

    /// Updates the specified cloudwatch alarm template group.
    pub fn updateCloudWatchAlarmTemplateGroup(self: *Self, allocator: std.mem.Allocator, input: update_cloud_watch_alarm_template_group.UpdateCloudWatchAlarmTemplateGroupInput, options: update_cloud_watch_alarm_template_group.Options) !update_cloud_watch_alarm_template_group.UpdateCloudWatchAlarmTemplateGroupOutput {
        return update_cloud_watch_alarm_template_group.execute(self, allocator, input, options);
    }

    /// Change the settings for a Cluster.
    pub fn updateCluster(self: *Self, allocator: std.mem.Allocator, input: update_cluster.UpdateClusterInput, options: update_cluster.Options) !update_cluster.UpdateClusterOutput {
        return update_cluster.execute(self, allocator, input, options);
    }

    /// Updates the specified eventbridge rule template.
    pub fn updateEventBridgeRuleTemplate(self: *Self, allocator: std.mem.Allocator, input: update_event_bridge_rule_template.UpdateEventBridgeRuleTemplateInput, options: update_event_bridge_rule_template.Options) !update_event_bridge_rule_template.UpdateEventBridgeRuleTemplateOutput {
        return update_event_bridge_rule_template.execute(self, allocator, input, options);
    }

    /// Updates the specified eventbridge rule template group.
    pub fn updateEventBridgeRuleTemplateGroup(self: *Self, allocator: std.mem.Allocator, input: update_event_bridge_rule_template_group.UpdateEventBridgeRuleTemplateGroupInput, options: update_event_bridge_rule_template_group.Options) !update_event_bridge_rule_template_group.UpdateEventBridgeRuleTemplateGroupOutput {
        return update_event_bridge_rule_template_group.execute(self, allocator, input, options);
    }

    /// Updates an input.
    pub fn updateInput(self: *Self, allocator: std.mem.Allocator, input: update_input.UpdateInputInput, options: update_input.Options) !update_input.UpdateInputOutput {
        return update_input.execute(self, allocator, input, options);
    }

    /// Updates the parameters for the input device.
    pub fn updateInputDevice(self: *Self, allocator: std.mem.Allocator, input: update_input_device.UpdateInputDeviceInput, options: update_input_device.Options) !update_input_device.UpdateInputDeviceOutput {
        return update_input_device.execute(self, allocator, input, options);
    }

    /// Update an Input Security Group's Whilelists.
    pub fn updateInputSecurityGroup(self: *Self, allocator: std.mem.Allocator, input: update_input_security_group.UpdateInputSecurityGroupInput, options: update_input_security_group.Options) !update_input_security_group.UpdateInputSecurityGroupOutput {
        return update_input_security_group.execute(self, allocator, input, options);
    }

    /// Updates a multiplex.
    pub fn updateMultiplex(self: *Self, allocator: std.mem.Allocator, input: update_multiplex.UpdateMultiplexInput, options: update_multiplex.Options) !update_multiplex.UpdateMultiplexOutput {
        return update_multiplex.execute(self, allocator, input, options);
    }

    /// Update a program in a multiplex.
    pub fn updateMultiplexProgram(self: *Self, allocator: std.mem.Allocator, input: update_multiplex_program.UpdateMultiplexProgramInput, options: update_multiplex_program.Options) !update_multiplex_program.UpdateMultiplexProgramOutput {
        return update_multiplex_program.execute(self, allocator, input, options);
    }

    /// Change the settings for a Network.
    pub fn updateNetwork(self: *Self, allocator: std.mem.Allocator, input: update_network.UpdateNetworkInput, options: update_network.Options) !update_network.UpdateNetworkOutput {
        return update_network.execute(self, allocator, input, options);
    }

    /// Change the settings for a Node.
    pub fn updateNode(self: *Self, allocator: std.mem.Allocator, input: update_node.UpdateNodeInput, options: update_node.Options) !update_node.UpdateNodeOutput {
        return update_node.execute(self, allocator, input, options);
    }

    /// Update the state of a node.
    pub fn updateNodeState(self: *Self, allocator: std.mem.Allocator, input: update_node_state.UpdateNodeStateInput, options: update_node_state.Options) !update_node_state.UpdateNodeStateOutput {
        return update_node_state.execute(self, allocator, input, options);
    }

    /// Update reservation.
    pub fn updateReservation(self: *Self, allocator: std.mem.Allocator, input: update_reservation.UpdateReservationInput, options: update_reservation.Options) !update_reservation.UpdateReservationOutput {
        return update_reservation.execute(self, allocator, input, options);
    }

    /// Change some of the settings in an SdiSource.
    pub fn updateSdiSource(self: *Self, allocator: std.mem.Allocator, input: update_sdi_source.UpdateSdiSourceInput, options: update_sdi_source.Options) !update_sdi_source.UpdateSdiSourceOutput {
        return update_sdi_source.execute(self, allocator, input, options);
    }

    pub fn describeSchedulePaginator(self: *Self, params: describe_schedule.DescribeScheduleInput) paginator.DescribeSchedulePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAlertsPaginator(self: *Self, params: list_alerts.ListAlertsInput) paginator.ListAlertsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listChannelPlacementGroupsPaginator(self: *Self, params: list_channel_placement_groups.ListChannelPlacementGroupsInput) paginator.ListChannelPlacementGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listChannelsPaginator(self: *Self, params: list_channels.ListChannelsInput) paginator.ListChannelsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCloudWatchAlarmTemplateGroupsPaginator(self: *Self, params: list_cloud_watch_alarm_template_groups.ListCloudWatchAlarmTemplateGroupsInput) paginator.ListCloudWatchAlarmTemplateGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCloudWatchAlarmTemplatesPaginator(self: *Self, params: list_cloud_watch_alarm_templates.ListCloudWatchAlarmTemplatesInput) paginator.ListCloudWatchAlarmTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listClusterAlertsPaginator(self: *Self, params: list_cluster_alerts.ListClusterAlertsInput) paginator.ListClusterAlertsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listClustersPaginator(self: *Self, params: list_clusters.ListClustersInput) paginator.ListClustersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEventBridgeRuleTemplateGroupsPaginator(self: *Self, params: list_event_bridge_rule_template_groups.ListEventBridgeRuleTemplateGroupsInput) paginator.ListEventBridgeRuleTemplateGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEventBridgeRuleTemplatesPaginator(self: *Self, params: list_event_bridge_rule_templates.ListEventBridgeRuleTemplatesInput) paginator.ListEventBridgeRuleTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInputDeviceTransfersPaginator(self: *Self, params: list_input_device_transfers.ListInputDeviceTransfersInput) paginator.ListInputDeviceTransfersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInputDevicesPaginator(self: *Self, params: list_input_devices.ListInputDevicesInput) paginator.ListInputDevicesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInputSecurityGroupsPaginator(self: *Self, params: list_input_security_groups.ListInputSecurityGroupsInput) paginator.ListInputSecurityGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInputsPaginator(self: *Self, params: list_inputs.ListInputsInput) paginator.ListInputsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMultiplexAlertsPaginator(self: *Self, params: list_multiplex_alerts.ListMultiplexAlertsInput) paginator.ListMultiplexAlertsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMultiplexProgramsPaginator(self: *Self, params: list_multiplex_programs.ListMultiplexProgramsInput) paginator.ListMultiplexProgramsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMultiplexesPaginator(self: *Self, params: list_multiplexes.ListMultiplexesInput) paginator.ListMultiplexesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listNetworksPaginator(self: *Self, params: list_networks.ListNetworksInput) paginator.ListNetworksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listNodesPaginator(self: *Self, params: list_nodes.ListNodesInput) paginator.ListNodesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listOfferingsPaginator(self: *Self, params: list_offerings.ListOfferingsInput) paginator.ListOfferingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listReservationsPaginator(self: *Self, params: list_reservations.ListReservationsInput) paginator.ListReservationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSdiSourcesPaginator(self: *Self, params: list_sdi_sources.ListSdiSourcesInput) paginator.ListSdiSourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSignalMapsPaginator(self: *Self, params: list_signal_maps.ListSignalMapsInput) paginator.ListSignalMapsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilChannelCreated(self: *Self, params: describe_channel.DescribeChannelInput) aws.waiter.WaiterError!void {
        var w = waiters.ChannelCreatedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilChannelDeleted(self: *Self, params: describe_channel.DescribeChannelInput) aws.waiter.WaiterError!void {
        var w = waiters.ChannelDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilChannelPlacementGroupAssigned(self: *Self, params: describe_channel_placement_group.DescribeChannelPlacementGroupInput) aws.waiter.WaiterError!void {
        var w = waiters.ChannelPlacementGroupAssignedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilChannelPlacementGroupDeleted(self: *Self, params: describe_channel_placement_group.DescribeChannelPlacementGroupInput) aws.waiter.WaiterError!void {
        var w = waiters.ChannelPlacementGroupDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilChannelPlacementGroupUnassigned(self: *Self, params: describe_channel_placement_group.DescribeChannelPlacementGroupInput) aws.waiter.WaiterError!void {
        var w = waiters.ChannelPlacementGroupUnassignedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilChannelRunning(self: *Self, params: describe_channel.DescribeChannelInput) aws.waiter.WaiterError!void {
        var w = waiters.ChannelRunningWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilChannelStopped(self: *Self, params: describe_channel.DescribeChannelInput) aws.waiter.WaiterError!void {
        var w = waiters.ChannelStoppedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilClusterCreated(self: *Self, params: describe_cluster.DescribeClusterInput) aws.waiter.WaiterError!void {
        var w = waiters.ClusterCreatedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilClusterDeleted(self: *Self, params: describe_cluster.DescribeClusterInput) aws.waiter.WaiterError!void {
        var w = waiters.ClusterDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilInputAttached(self: *Self, params: describe_input.DescribeInputInput) aws.waiter.WaiterError!void {
        var w = waiters.InputAttachedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilInputDeleted(self: *Self, params: describe_input.DescribeInputInput) aws.waiter.WaiterError!void {
        var w = waiters.InputDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilInputDetached(self: *Self, params: describe_input.DescribeInputInput) aws.waiter.WaiterError!void {
        var w = waiters.InputDetachedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilMultiplexCreated(self: *Self, params: describe_multiplex.DescribeMultiplexInput) aws.waiter.WaiterError!void {
        var w = waiters.MultiplexCreatedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilMultiplexDeleted(self: *Self, params: describe_multiplex.DescribeMultiplexInput) aws.waiter.WaiterError!void {
        var w = waiters.MultiplexDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilMultiplexRunning(self: *Self, params: describe_multiplex.DescribeMultiplexInput) aws.waiter.WaiterError!void {
        var w = waiters.MultiplexRunningWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilMultiplexStopped(self: *Self, params: describe_multiplex.DescribeMultiplexInput) aws.waiter.WaiterError!void {
        var w = waiters.MultiplexStoppedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilNodeDeregistered(self: *Self, params: describe_node.DescribeNodeInput) aws.waiter.WaiterError!void {
        var w = waiters.NodeDeregisteredWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilNodeRegistered(self: *Self, params: describe_node.DescribeNodeInput) aws.waiter.WaiterError!void {
        var w = waiters.NodeRegisteredWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilSignalMapCreated(self: *Self, params: get_signal_map.GetSignalMapInput) aws.waiter.WaiterError!void {
        var w = waiters.SignalMapCreatedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilSignalMapMonitorDeleted(self: *Self, params: get_signal_map.GetSignalMapInput) aws.waiter.WaiterError!void {
        var w = waiters.SignalMapMonitorDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilSignalMapMonitorDeployed(self: *Self, params: get_signal_map.GetSignalMapInput) aws.waiter.WaiterError!void {
        var w = waiters.SignalMapMonitorDeployedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilSignalMapUpdated(self: *Self, params: get_signal_map.GetSignalMapInput) aws.waiter.WaiterError!void {
        var w = waiters.SignalMapUpdatedWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
