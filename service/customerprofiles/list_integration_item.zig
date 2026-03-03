const aws = @import("aws");

const Scope = @import("scope.zig").Scope;

/// An integration in list of integrations.
pub const ListIntegrationItem = struct {
    /// The timestamp of when the domain was created.
    created_at: i64,

    /// The unique name of the domain.
    domain_name: []const u8,

    /// A list of unique names for active event triggers associated with the
    /// integration.
    event_trigger_names: ?[]const []const u8 = null,

    /// Boolean that shows if the Flow that's associated with the Integration is
    /// created in
    /// Amazon Appflow, or with ObjectTypeName equals _unstructured via API/CLI in
    /// flowDefinition.
    is_unstructured: ?bool = null,

    /// The timestamp of when the integration was most recently edited.
    last_updated_at: i64,

    /// The name of the profile object type.
    object_type_name: ?[]const u8 = null,

    /// A map in which each key is an event type from an external application such
    /// as Segment or Shopify, and each value is an `ObjectTypeName` (template) used
    /// to ingest the event.
    /// It supports the following event types: `SegmentIdentify`,
    /// `ShopifyCreateCustomers`, `ShopifyUpdateCustomers`,
    /// `ShopifyCreateDraftOrders`,
    /// `ShopifyUpdateDraftOrders`, `ShopifyCreateOrders`, and
    /// `ShopifyUpdatedOrders`.
    object_type_names: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Resource Name (ARN) of the IAM role. The Integration uses this
    /// role to make
    /// Customer Profiles requests on your behalf.
    role_arn: ?[]const u8 = null,

    /// The scope or boundary of the integration item's applicability.
    scope: ?Scope = null,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The URI of the S3 bucket or any other type of data source.
    uri: []const u8,

    /// Unique identifier for the workflow.
    workflow_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .domain_name = "DomainName",
        .event_trigger_names = "EventTriggerNames",
        .is_unstructured = "IsUnstructured",
        .last_updated_at = "LastUpdatedAt",
        .object_type_name = "ObjectTypeName",
        .object_type_names = "ObjectTypeNames",
        .role_arn = "RoleArn",
        .scope = "Scope",
        .tags = "Tags",
        .uri = "Uri",
        .workflow_id = "WorkflowId",
    };
};
