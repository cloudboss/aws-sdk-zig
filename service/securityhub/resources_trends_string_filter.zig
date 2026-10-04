const ResourcesTrendsStringField = @import("resources_trends_string_field.zig").ResourcesTrendsStringField;
const StringFilter = @import("string_filter.zig").StringFilter;

/// A filter for string-based fields in resources trend data, such as resource
/// type or account ID.
pub const ResourcesTrendsStringFilter = struct {
    /// The name of the resources field to filter on. You can specify one of the
    /// following fields.
    ///
    /// * `account_id` – The Amazon Web Services account ID that owns the resource.
    ///
    /// * `region` – The Amazon Web Services Region of the resource.
    ///
    /// * `resource_type` – The type of the resource.
    ///
    /// * `resource_category` – The category of the resource.
    ///
    /// * `resource_cloud_provider` – The cloud provider of the resource. Valid
    ///   values are `AWS` and `Azure`.
    ///
    /// * `resource_region` – The Region of the resource. For an Amazon Web Services
    ///   resource, this is the Amazon Web Services Region. For an Azure resource,
    ///   this is the Azure Region, such as `eastus`.
    ///
    /// * `resource_owner_id` – The identifier of the account that owns the
    ///   resource. For an Amazon Web Services resource, this is the Amazon Web
    ///   Services account ID. For an Azure resource, this is the Azure subscription
    ///   ID.
    ///
    /// * `resource_owner_organization_id` – The identifier of the organization that
    ///   owns the resource. For an Amazon Web Services resource, this is the Amazon
    ///   Web Services organization ID. For an Azure resource, this is the Azure
    ///   tenant ID.
    field_name: ?ResourcesTrendsStringField = null,

    filter: ?StringFilter = null,

    pub const json_field_names = .{
        .field_name = "FieldName",
        .filter = "Filter",
    };
};
