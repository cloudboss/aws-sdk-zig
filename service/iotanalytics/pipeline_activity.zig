const AddAttributesActivity = @import("add_attributes_activity.zig").AddAttributesActivity;
const ChannelActivity = @import("channel_activity.zig").ChannelActivity;
const DatastoreActivity = @import("datastore_activity.zig").DatastoreActivity;
const DeviceRegistryEnrichActivity = @import("device_registry_enrich_activity.zig").DeviceRegistryEnrichActivity;
const DeviceShadowEnrichActivity = @import("device_shadow_enrich_activity.zig").DeviceShadowEnrichActivity;
const FilterActivity = @import("filter_activity.zig").FilterActivity;
const LambdaActivity = @import("lambda_activity.zig").LambdaActivity;
const MathActivity = @import("math_activity.zig").MathActivity;
const RemoveAttributesActivity = @import("remove_attributes_activity.zig").RemoveAttributesActivity;
const SelectAttributesActivity = @import("select_attributes_activity.zig").SelectAttributesActivity;

/// An activity that performs a transformation on a message.
pub const PipelineActivity = struct {
    /// Adds other attributes based on existing attributes in the message.
    add_attributes: ?AddAttributesActivity,

    /// Determines the source of the messages to be processed.
    channel: ?ChannelActivity,

    /// Specifies where to store the processed message data.
    datastore: ?DatastoreActivity,

    /// Adds data from the IoT device registry to your message.
    device_registry_enrich: ?DeviceRegistryEnrichActivity,

    /// Adds information from the IoT Device Shadow service to a message.
    device_shadow_enrich: ?DeviceShadowEnrichActivity,

    /// Filters a message based on its attributes.
    filter: ?FilterActivity,

    /// Runs a Lambda function to modify the message.
    lambda: ?LambdaActivity,

    /// Computes an arithmetic expression using the message's attributes and adds it
    /// to the
    /// message.
    math: ?MathActivity,

    /// Removes attributes from a message.
    remove_attributes: ?RemoveAttributesActivity,

    /// Used to create a new message using only the specified attributes from the
    /// original
    /// message.
    select_attributes: ?SelectAttributesActivity,

    pub const json_field_names = .{
        .add_attributes = "addAttributes",
        .channel = "channel",
        .datastore = "datastore",
        .device_registry_enrich = "deviceRegistryEnrich",
        .device_shadow_enrich = "deviceShadowEnrich",
        .filter = "filter",
        .lambda = "lambda",
        .math = "math",
        .remove_attributes = "removeAttributes",
        .select_attributes = "selectAttributes",
    };
};
