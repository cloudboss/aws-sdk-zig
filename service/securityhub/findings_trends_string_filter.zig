const FindingsTrendsStringField = @import("findings_trends_string_field.zig").FindingsTrendsStringField;
const StringFilter = @import("string_filter.zig").StringFilter;

/// A filter for string-based fields in findings trend data.
pub const FindingsTrendsStringFilter = struct {
    /// The name of the findings field to filter on. You can specify one of the
    /// following fields.
    ///
    /// * `account_id` – The Amazon Web Services account ID associated with the
    ///   finding.
    ///
    /// * `region` – The Amazon Web Services Region associated with the finding.
    ///
    /// * `finding_types` – The finding types associated with the finding.
    ///
    /// * `finding_status` – The status of the finding.
    ///
    /// * `finding_cve_ids` – The Common Vulnerabilities and Exposures (CVE)
    ///   identifiers associated with the finding.
    ///
    /// * `finding_compliance_status` – The compliance status of the finding.
    ///
    /// * `finding_control_id` – The identifier of the security control associated
    ///   with the finding.
    ///
    /// * `finding_class_name` – The finding class, such as `Compliance Finding`.
    ///
    /// * `finding_provider` – The name of the product that generated the finding.
    ///
    /// * `finding_activity_name` – The activity name associated with the finding.
    ///
    /// * `resource_cloud_providers` – The cloud providers of the resources that the
    ///   finding is associated with. Valid values are `AWS` and `Azure`.
    ///
    /// * `resource_regions` – The Regions of the associated resources. For an
    ///   Amazon Web Services resource, this is the Amazon Web Services Region. For
    ///   an Azure resource, this is the Azure Region, such as `eastus`.
    ///
    /// * `resource_owner_ids` – The identifiers of the accounts that own the
    ///   associated resources. For an Amazon Web Services resource, this is the
    ///   Amazon Web Services account ID. For an Azure resource, this is the Azure
    ///   subscription ID.
    ///
    /// * `resource_owner_organization_ids` – The identifiers of the organizations
    ///   that own the associated resources. For an Amazon Web Services resource,
    ///   this is the Amazon Web Services organization ID. For an Azure resource,
    ///   this is the Azure tenant ID.
    field_name: ?FindingsTrendsStringField = null,

    filter: ?StringFilter = null,

    pub const json_field_names = .{
        .field_name = "FieldName",
        .filter = "Filter",
    };
};
