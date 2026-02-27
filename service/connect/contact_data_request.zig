const aws = @import("aws");

const Campaign = @import("campaign.zig").Campaign;
const Endpoint = @import("endpoint.zig").Endpoint;
const OutboundStrategy = @import("outbound_strategy.zig").OutboundStrategy;

/// Request object with information to create a contact.
pub const ContactDataRequest = struct {
    /// List of attributes to be stored in a contact.
    attributes: ?[]const aws.map.StringMapEntry,

    /// Structure to store information associated with a campaign.
    campaign: ?Campaign,

    /// Endpoint of the customer for which contact will be initiated.
    customer_endpoint: ?Endpoint,

    /// Information about the outbound strategy.
    outbound_strategy: ?OutboundStrategy,

    /// The identifier of the queue associated with the Amazon Connect instance in
    /// which contacts that are created
    /// will be queued.
    queue_id: ?[]const u8,

    /// Identifier to uniquely identify individual requests in the batch.
    request_identifier: ?[]const u8,

    /// Endpoint associated with the Amazon Connect instance from which outbound
    /// contact will be initiated for the
    /// campaign.
    system_endpoint: ?Endpoint,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .campaign = "Campaign",
        .customer_endpoint = "CustomerEndpoint",
        .outbound_strategy = "OutboundStrategy",
        .queue_id = "QueueId",
        .request_identifier = "RequestIdentifier",
        .system_endpoint = "SystemEndpoint",
    };
};
