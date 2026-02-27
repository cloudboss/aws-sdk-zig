const DataTransfer = @import("data_transfer.zig").DataTransfer;
const DeviceConfiguration = @import("device_configuration.zig").DeviceConfiguration;
const ImpactLevel = @import("impact_level.zig").ImpactLevel;
const JobLogs = @import("job_logs.zig").JobLogs;
const JobState = @import("job_state.zig").JobState;
const JobType = @import("job_type.zig").JobType;
const Notification = @import("notification.zig").Notification;
const OnDeviceServiceConfiguration = @import("on_device_service_configuration.zig").OnDeviceServiceConfiguration;
const PickupDetails = @import("pickup_details.zig").PickupDetails;
const RemoteManagement = @import("remote_management.zig").RemoteManagement;
const JobResource = @import("job_resource.zig").JobResource;
const ShippingDetails = @import("shipping_details.zig").ShippingDetails;
const SnowballCapacity = @import("snowball_capacity.zig").SnowballCapacity;
const SnowballType = @import("snowball_type.zig").SnowballType;
const TaxDocuments = @import("tax_documents.zig").TaxDocuments;

/// Contains information about a specific job including shipping information,
/// job status,
/// and other important metadata. This information is returned as a part of the
/// response syntax of
/// the `DescribeJob` action.
pub const JobMetadata = struct {
    /// The ID for the address that you want the Snow device shipped to.
    address_id: ?[]const u8,

    /// The 39-character ID for the cluster, for example
    /// `CID123e4567-e89b-12d3-a456-426655440000`.
    cluster_id: ?[]const u8,

    /// The creation date for this job.
    creation_date: ?i64,

    /// A value that defines the real-time status of a Snow device's data transfer
    /// while the
    /// device is at Amazon Web Services. This data is only available while a job
    /// has a
    /// `JobState` value of `InProgress`, for both import and export
    /// jobs.
    data_transfer_progress: ?DataTransfer,

    /// The description of the job, provided at job creation.
    description: ?[]const u8,

    device_configuration: ?DeviceConfiguration,

    /// The ID of the address that you want a job shipped to, after it will be
    /// shipped to its primary address. This field is not supported in most regions.
    forwarding_address_id: ?[]const u8,

    /// The highest impact level of data that will be stored or processed on the
    /// device, provided at job creation.
    impact_level: ?ImpactLevel,

    /// The automatically generated ID for a job, for example
    /// `JID123e4567-e89b-12d3-a456-426655440000`.
    job_id: ?[]const u8,

    /// Links to Amazon S3 presigned URLs for the job report and logs. For import
    /// jobs, the PDF
    /// job report becomes available at the end of the import process. For export
    /// jobs, your job
    /// report typically becomes available while the Snow device for your job part
    /// is being delivered
    /// to you.
    job_log_info: ?JobLogs,

    /// The current status of the jobs.
    job_state: ?JobState,

    /// The type of job.
    job_type: ?JobType,

    /// The Amazon Resource Name (ARN) for the Key Management Service (KMS) key
    /// associated with this job. This ARN was created using the
    /// [CreateKey](https://docs.aws.amazon.com/kms/latest/APIReference/API_CreateKey.html) API action in KMS.
    kms_key_arn: ?[]const u8,

    /// The ID of the long-term pricing type for the device.
    long_term_pricing_id: ?[]const u8,

    /// The Amazon Simple Notification Service (Amazon SNS) notification settings
    /// associated
    /// with a specific job. The `Notification` object is returned as a part of the
    /// response syntax of the `DescribeJob` action in the `JobMetadata` data
    /// type.
    notification: ?Notification,

    /// Represents metadata and configuration settings for services on an Amazon Web
    /// Services Snow Family
    /// device.
    on_device_service_configuration: ?OnDeviceServiceConfiguration,

    /// Information identifying the person picking up the device.
    pickup_details: ?PickupDetails,

    /// Allows you to securely operate and manage Snowcone devices remotely from
    /// outside of your
    /// internal network. When set to `INSTALLED_AUTOSTART`, remote management will
    /// automatically be available when the device arrives at your location.
    /// Otherwise, you need to
    /// use the Snowball Client to manage the device.
    remote_management: ?RemoteManagement,

    /// An array of `S3Resource` objects. Each `S3Resource` object
    /// represents an Amazon S3 bucket that your transferred data will be exported
    /// from or imported
    /// into.
    resources: ?JobResource,

    /// The role ARN associated with this job. This ARN was created using the
    /// [CreateRole](https://docs.aws.amazon.com/IAM/latest/APIReference/API_CreateRole.html)
    /// API action in Identity and Access Management.
    role_arn: ?[]const u8,

    /// A job's shipping information, including inbound and outbound tracking
    /// numbers and
    /// shipping speed options.
    shipping_details: ?ShippingDetails,

    /// The Snow device capacity preference for this job, specified at job creation.
    /// In US
    /// regions, you can choose between 50 TB and 80 TB Snowballs. All other regions
    /// use 80 TB
    /// capacity Snowballs.
    ///
    /// For more information, see
    /// "https://docs.aws.amazon.com/snowball/latest/snowcone-guide/snow-device-types.html" (Snow
    /// Family Devices and Capacity) in the *Snowcone User Guide* or
    /// "https://docs.aws.amazon.com/snowball/latest/developer-guide/snow-device-types.html" (Snow
    /// Family Devices and Capacity) in the *Snowcone User Guide*.
    snowball_capacity_preference: ?SnowballCapacity,

    /// Unique ID associated with a device.
    snowball_id: ?[]const u8,

    /// The type of device used with this job.
    snowball_type: ?SnowballType,

    /// The metadata associated with the tax documents required in your Amazon Web
    /// Services Region.
    tax_documents: ?TaxDocuments,

    pub const json_field_names = .{
        .address_id = "AddressId",
        .cluster_id = "ClusterId",
        .creation_date = "CreationDate",
        .data_transfer_progress = "DataTransferProgress",
        .description = "Description",
        .device_configuration = "DeviceConfiguration",
        .forwarding_address_id = "ForwardingAddressId",
        .impact_level = "ImpactLevel",
        .job_id = "JobId",
        .job_log_info = "JobLogInfo",
        .job_state = "JobState",
        .job_type = "JobType",
        .kms_key_arn = "KmsKeyARN",
        .long_term_pricing_id = "LongTermPricingId",
        .notification = "Notification",
        .on_device_service_configuration = "OnDeviceServiceConfiguration",
        .pickup_details = "PickupDetails",
        .remote_management = "RemoteManagement",
        .resources = "Resources",
        .role_arn = "RoleARN",
        .shipping_details = "ShippingDetails",
        .snowball_capacity_preference = "SnowballCapacityPreference",
        .snowball_id = "SnowballId",
        .snowball_type = "SnowballType",
        .tax_documents = "TaxDocuments",
    };
};
