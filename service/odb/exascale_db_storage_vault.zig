const ShapeAttribute = @import("shape_attribute.zig").ShapeAttribute;
const ExascaleDbStorageDetails = @import("exascale_db_storage_details.zig").ExascaleDbStorageDetails;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

/// Information about an Exascale storage vault.
pub const ExascaleDbStorageVault = struct {
    /// The additional flash cache percentage for the Exascale storage vault.
    additional_flash_cache_in_percent: ?i32 = null,

    /// The list of shape attributes attached to the Exascale storage vault.
    attached_shape_attributes: ?[]const ShapeAttribute = null,

    /// The autoscale limit in gigabytes (GB) for the Exascale storage vault.
    autoscale_limit_in_g_bs: ?i32 = null,

    /// The Availability Zone for the Exascale storage vault.
    availability_zone: ?[]const u8 = null,

    /// The Availability Zone ID for the Exascale storage vault.
    availability_zone_id: ?[]const u8 = null,

    /// The date and time when the Exascale storage vault was created.
    created_at: ?i64 = null,

    /// The description of the Exascale storage vault.
    description: ?[]const u8 = null,

    /// The user-friendly name for the Exascale storage vault.
    display_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Exascale storage vault.
    exascale_db_storage_vault_arn: ?[]const u8 = null,

    /// The unique identifier of the Exascale storage vault.
    exascale_db_storage_vault_id: []const u8,

    /// The high-capacity database storage details for the Exascale storage vault.
    high_capacity_database_storage: ?ExascaleDbStorageDetails = null,

    /// Specifies whether autoscaling is enabled for the Exascale storage vault.
    is_autoscale_enabled: ?bool = null,

    /// The OCID of the Exascale storage vault.
    ocid: ?[]const u8 = null,

    /// The name of the OCI resource anchor for the Exascale storage vault.
    oci_resource_anchor_name: ?[]const u8 = null,

    /// The HTTPS link to the Exascale storage vault in Oracle Cloud Infrastructure
    /// (OCI).
    oci_url: ?[]const u8 = null,

    /// The amount of progress made on the current operation on the Exascale storage
    /// vault, expressed as a percentage.
    percent_progress: ?f32 = null,

    /// The current status of the Exascale storage vault.
    status: ?ResourceStatus = null,

    /// Additional information about the status of the Exascale storage vault.
    status_reason: ?[]const u8 = null,

    /// The time zone of the Exascale storage vault.
    time_zone: ?[]const u8 = null,

    /// The list of Amazon Resource Names (ARNs) of the VM clusters associated with
    /// this Exascale storage vault.
    vm_cluster_arns: ?[]const []const u8 = null,

    /// The number of VM clusters associated with this Exascale storage vault.
    vm_cluster_count: ?i32 = null,

    /// The list of unique identifiers of the VM clusters associated with this
    /// Exascale storage vault.
    vm_cluster_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .additional_flash_cache_in_percent = "additionalFlashCacheInPercent",
        .attached_shape_attributes = "attachedShapeAttributes",
        .autoscale_limit_in_g_bs = "autoscaleLimitInGBs",
        .availability_zone = "availabilityZone",
        .availability_zone_id = "availabilityZoneId",
        .created_at = "createdAt",
        .description = "description",
        .display_name = "displayName",
        .exascale_db_storage_vault_arn = "exascaleDbStorageVaultArn",
        .exascale_db_storage_vault_id = "exascaleDbStorageVaultId",
        .high_capacity_database_storage = "highCapacityDatabaseStorage",
        .is_autoscale_enabled = "isAutoscaleEnabled",
        .ocid = "ocid",
        .oci_resource_anchor_name = "ociResourceAnchorName",
        .oci_url = "ociUrl",
        .percent_progress = "percentProgress",
        .status = "status",
        .status_reason = "statusReason",
        .time_zone = "timeZone",
        .vm_cluster_arns = "vmClusterArns",
        .vm_cluster_count = "vmClusterCount",
        .vm_cluster_ids = "vmClusterIds",
    };
};
