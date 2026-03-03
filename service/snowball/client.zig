const aws = @import("aws");
const std = @import("std");

const cancel_cluster = @import("cancel_cluster.zig");
const cancel_job = @import("cancel_job.zig");
const create_address = @import("create_address.zig");
const create_cluster = @import("create_cluster.zig");
const create_job = @import("create_job.zig");
const create_long_term_pricing = @import("create_long_term_pricing.zig");
const create_return_shipping_label = @import("create_return_shipping_label.zig");
const describe_address = @import("describe_address.zig");
const describe_addresses = @import("describe_addresses.zig");
const describe_cluster = @import("describe_cluster.zig");
const describe_job = @import("describe_job.zig");
const describe_return_shipping_label = @import("describe_return_shipping_label.zig");
const get_job_manifest = @import("get_job_manifest.zig");
const get_job_unlock_code = @import("get_job_unlock_code.zig");
const get_snowball_usage = @import("get_snowball_usage.zig");
const get_software_updates = @import("get_software_updates.zig");
const list_cluster_jobs = @import("list_cluster_jobs.zig");
const list_clusters = @import("list_clusters.zig");
const list_compatible_images = @import("list_compatible_images.zig");
const list_jobs = @import("list_jobs.zig");
const list_long_term_pricing = @import("list_long_term_pricing.zig");
const list_pickup_locations = @import("list_pickup_locations.zig");
const list_service_versions = @import("list_service_versions.zig");
const update_cluster = @import("update_cluster.zig");
const update_job = @import("update_job.zig");
const update_job_shipment_state = @import("update_job_shipment_state.zig");
const update_long_term_pricing = @import("update_long_term_pricing.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Snowball";

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

    /// Cancels a cluster job. You can only cancel a cluster job while it's in the
    /// `AwaitingQuorum` status. You'll have at least an hour after creating a
    /// cluster
    /// job to cancel it.
    pub fn cancelCluster(self: *Self, allocator: std.mem.Allocator, input: cancel_cluster.CancelClusterInput, options: cancel_cluster.Options) !cancel_cluster.CancelClusterOutput {
        return cancel_cluster.execute(self, allocator, input, options);
    }

    /// Cancels the specified job. You can only cancel a job before its `JobState`
    /// value changes to `PreparingAppliance`. Requesting the `ListJobs` or
    /// `DescribeJob` action returns a job's `JobState` as part of the
    /// response element data returned.
    pub fn cancelJob(self: *Self, allocator: std.mem.Allocator, input: cancel_job.CancelJobInput, options: cancel_job.Options) !cancel_job.CancelJobOutput {
        return cancel_job.execute(self, allocator, input, options);
    }

    /// Creates an address for a Snow device to be shipped to. In most regions,
    /// addresses are validated at the time of creation. The address you provide
    /// must be located
    /// within the serviceable area of your region. If the address is invalid or
    /// unsupported, then an
    /// exception is thrown. If providing an address as a JSON file through the
    /// `cli-input-json` option, include the full file path. For example,
    /// `--cli-input-json file://create-address.json`.
    pub fn createAddress(self: *Self, allocator: std.mem.Allocator, input: create_address.CreateAddressInput, options: create_address.Options) !create_address.CreateAddressOutput {
        return create_address.execute(self, allocator, input, options);
    }

    /// Creates an empty cluster. Each cluster supports five nodes. You use the
    /// CreateJob action separately to create the jobs for each of these nodes. The
    /// cluster does not ship until these five node jobs have been created.
    pub fn createCluster(self: *Self, allocator: std.mem.Allocator, input: create_cluster.CreateClusterInput, options: create_cluster.Options) !create_cluster.CreateClusterOutput {
        return create_cluster.execute(self, allocator, input, options);
    }

    /// Creates a job to import or export data between Amazon S3 and your
    /// on-premises data
    /// center. Your Amazon Web Services account must have the right trust policies
    /// and permissions in
    /// place to create a job for a Snow device. If you're creating a job for a node
    /// in a cluster, you
    /// only need to provide the `clusterId` value; the other job attributes are
    /// inherited
    /// from the cluster.
    ///
    /// Only the Snowball; Edge device type is supported when ordering clustered
    /// jobs.
    ///
    /// The device capacity is optional.
    ///
    /// Availability of device types differ by Amazon Web Services Region. For more
    /// information
    /// about Region availability, see [Amazon Web Services Regional
    /// Services](https://aws.amazon.com/about-aws/global-infrastructure/regional-product-services/?p=ngi&loc=4).
    ///
    /// **Snow Family devices and their capacities.**
    ///
    /// * Device type: **SNC1_SSD**
    ///
    /// * Capacity: T14
    ///
    /// * Description: Snowcone
    ///
    /// * Device type: **SNC1_HDD**
    ///
    /// * Capacity: T8
    ///
    /// * Description: Snowcone
    ///
    /// * Device type: **EDGE_S**
    ///
    /// * Capacity: T98
    ///
    /// * Description: Snowball Edge Storage Optimized for data transfer only
    ///
    /// * Device type: **EDGE_CG**
    ///
    /// * Capacity: T42
    ///
    /// * Description: Snowball Edge Compute Optimized with GPU
    ///
    /// * Device type: **EDGE_C**
    ///
    /// * Capacity: T42
    ///
    /// * Description: Snowball Edge Compute Optimized without GPU
    ///
    /// * Device type: **EDGE**
    ///
    /// * Capacity: T100
    ///
    /// * Description: Snowball Edge Storage Optimized with EC2 Compute
    ///
    /// This device is replaced with T98.
    ///
    /// * Device type: **STANDARD**
    ///
    /// * Capacity: T50
    ///
    /// * Description: Original Snowball device
    ///
    /// This device is only available in the Ningxia, Beijing, and Singapore Amazon
    /// Web Services Region
    ///
    /// * Device type: **STANDARD**
    ///
    /// * Capacity: T80
    ///
    /// * Description: Original Snowball device
    ///
    /// This device is only available in the Ningxia, Beijing, and Singapore Amazon
    /// Web Services Region.
    ///
    /// * Snow Family device type: **RACK_5U_C**
    ///
    /// * Capacity: T13
    ///
    /// * Description: Snowblade.
    ///
    /// * Device type: **V3_5S**
    ///
    /// * Capacity: T240
    ///
    /// * Description: Snowball Edge Storage Optimized 210TB
    pub fn createJob(self: *Self, allocator: std.mem.Allocator, input: create_job.CreateJobInput, options: create_job.Options) !create_job.CreateJobOutput {
        return create_job.execute(self, allocator, input, options);
    }

    /// Creates a job with the long-term usage option for a device. The long-term
    /// usage is a
    /// 1-year or 3-year long-term pricing type for the device. You are billed
    /// upfront, and Amazon Web Services provides discounts for long-term pricing.
    pub fn createLongTermPricing(self: *Self, allocator: std.mem.Allocator, input: create_long_term_pricing.CreateLongTermPricingInput, options: create_long_term_pricing.Options) !create_long_term_pricing.CreateLongTermPricingOutput {
        return create_long_term_pricing.execute(self, allocator, input, options);
    }

    /// Creates a shipping label that will be used to return the Snow device to
    /// Amazon Web Services.
    pub fn createReturnShippingLabel(self: *Self, allocator: std.mem.Allocator, input: create_return_shipping_label.CreateReturnShippingLabelInput, options: create_return_shipping_label.Options) !create_return_shipping_label.CreateReturnShippingLabelOutput {
        return create_return_shipping_label.execute(self, allocator, input, options);
    }

    /// Takes an `AddressId` and returns specific details about that address in the
    /// form of an `Address` object.
    pub fn describeAddress(self: *Self, allocator: std.mem.Allocator, input: describe_address.DescribeAddressInput, options: describe_address.Options) !describe_address.DescribeAddressOutput {
        return describe_address.execute(self, allocator, input, options);
    }

    /// Returns a specified number of `ADDRESS` objects. Calling this API in one of
    /// the US regions will return addresses from the list of all addresses
    /// associated with this
    /// account in all US regions.
    pub fn describeAddresses(self: *Self, allocator: std.mem.Allocator, input: describe_addresses.DescribeAddressesInput, options: describe_addresses.Options) !describe_addresses.DescribeAddressesOutput {
        return describe_addresses.execute(self, allocator, input, options);
    }

    /// Returns information about a specific cluster including shipping information,
    /// cluster
    /// status, and other important metadata.
    pub fn describeCluster(self: *Self, allocator: std.mem.Allocator, input: describe_cluster.DescribeClusterInput, options: describe_cluster.Options) !describe_cluster.DescribeClusterOutput {
        return describe_cluster.execute(self, allocator, input, options);
    }

    /// Returns information about a specific job including shipping information, job
    /// status,
    /// and other important metadata.
    pub fn describeJob(self: *Self, allocator: std.mem.Allocator, input: describe_job.DescribeJobInput, options: describe_job.Options) !describe_job.DescribeJobOutput {
        return describe_job.execute(self, allocator, input, options);
    }

    /// Information on the shipping label of a Snow device that is being returned to
    /// Amazon Web Services.
    pub fn describeReturnShippingLabel(self: *Self, allocator: std.mem.Allocator, input: describe_return_shipping_label.DescribeReturnShippingLabelInput, options: describe_return_shipping_label.Options) !describe_return_shipping_label.DescribeReturnShippingLabelOutput {
        return describe_return_shipping_label.execute(self, allocator, input, options);
    }

    /// Returns a link to an Amazon S3 presigned URL for the manifest file
    /// associated with the
    /// specified `JobId` value. You can access the manifest file for up to 60
    /// minutes
    /// after this request has been made. To access the manifest file after 60
    /// minutes have passed,
    /// you'll have to make another call to the `GetJobManifest` action.
    ///
    /// The manifest is an encrypted file that you can download after your job
    /// enters the
    /// `WithCustomer` status. This is the only valid status for calling this API as
    /// the
    /// manifest and `UnlockCode` code value are used for securing your device and
    /// should
    /// only be used when you have the device. The manifest is decrypted by using
    /// the
    /// `UnlockCode` code value, when you pass both values to the Snow device
    /// through the
    /// Snowball client when the client is started for the first time.
    ///
    /// As a best practice, we recommend that you don't save a copy of an
    /// `UnlockCode` value in the same location as the manifest file for that job.
    /// Saving
    /// these separately helps prevent unauthorized parties from gaining access to
    /// the Snow device
    /// associated with that job.
    ///
    /// The credentials of a given job, including its manifest file and unlock code,
    /// expire 360
    /// days after the job is created.
    pub fn getJobManifest(self: *Self, allocator: std.mem.Allocator, input: get_job_manifest.GetJobManifestInput, options: get_job_manifest.Options) !get_job_manifest.GetJobManifestOutput {
        return get_job_manifest.execute(self, allocator, input, options);
    }

    /// Returns the `UnlockCode` code value for the specified job. A particular
    /// `UnlockCode` value can be accessed for up to 360 days after the associated
    /// job
    /// has been created.
    ///
    /// The `UnlockCode` value is a 29-character code with 25 alphanumeric
    /// characters and 4 hyphens. This code is used to decrypt the manifest file
    /// when it is passed
    /// along with the manifest to the Snow device through the Snowball client when
    /// the client is
    /// started for the first time. The only valid status for calling this API is
    /// `WithCustomer` as the manifest and `Unlock` code values are used for
    /// securing your device and should only be used when you have the device.
    ///
    /// As a best practice, we recommend that you don't save a copy of the
    /// `UnlockCode` in the same location as the manifest file for that job. Saving
    /// these
    /// separately helps prevent unauthorized parties from gaining access to the
    /// Snow device
    /// associated with that job.
    pub fn getJobUnlockCode(self: *Self, allocator: std.mem.Allocator, input: get_job_unlock_code.GetJobUnlockCodeInput, options: get_job_unlock_code.Options) !get_job_unlock_code.GetJobUnlockCodeOutput {
        return get_job_unlock_code.execute(self, allocator, input, options);
    }

    /// Returns information about the Snow Family service limit for your account,
    /// and also the
    /// number of Snow devices your account has in use.
    ///
    /// The default service limit for the number of Snow devices that you can have
    /// at one time
    /// is 1. If you want to increase your service limit, contact Amazon Web
    /// Services Support.
    pub fn getSnowballUsage(self: *Self, allocator: std.mem.Allocator, input: get_snowball_usage.GetSnowballUsageInput, options: get_snowball_usage.Options) !get_snowball_usage.GetSnowballUsageOutput {
        return get_snowball_usage.execute(self, allocator, input, options);
    }

    /// Returns an Amazon S3 presigned URL for an update file associated with a
    /// specified
    /// `JobId`.
    pub fn getSoftwareUpdates(self: *Self, allocator: std.mem.Allocator, input: get_software_updates.GetSoftwareUpdatesInput, options: get_software_updates.Options) !get_software_updates.GetSoftwareUpdatesOutput {
        return get_software_updates.execute(self, allocator, input, options);
    }

    /// Returns an array of `JobListEntry` objects of the specified length. Each
    /// `JobListEntry` object is for a job in the specified cluster and contains a
    /// job's
    /// state, a job's ID, and other information.
    pub fn listClusterJobs(self: *Self, allocator: std.mem.Allocator, input: list_cluster_jobs.ListClusterJobsInput, options: list_cluster_jobs.Options) !list_cluster_jobs.ListClusterJobsOutput {
        return list_cluster_jobs.execute(self, allocator, input, options);
    }

    /// Returns an array of `ClusterListEntry` objects of the specified length. Each
    /// `ClusterListEntry` object contains a cluster's state, a cluster's ID, and
    /// other
    /// important status information.
    pub fn listClusters(self: *Self, allocator: std.mem.Allocator, input: list_clusters.ListClustersInput, options: list_clusters.Options) !list_clusters.ListClustersOutput {
        return list_clusters.execute(self, allocator, input, options);
    }

    /// This action returns a list of the different Amazon EC2-compatible Amazon
    /// Machine Images (AMIs)
    /// that are owned by your Amazon Web Services accountthat would be supported
    /// for use on a Snow
    /// device. Currently, supported AMIs are based on the Amazon Linux-2, Ubuntu
    /// 20.04 LTS - Focal, or Ubuntu 22.04 LTS - Jammy images, available on the
    /// Amazon Web Services Marketplace. Ubuntu 16.04 LTS - Xenial (HVM) images are
    /// no longer supported in the Market, but still supported for use on devices
    /// through Amazon EC2 VM Import/Export and running locally in AMIs.
    pub fn listCompatibleImages(self: *Self, allocator: std.mem.Allocator, input: list_compatible_images.ListCompatibleImagesInput, options: list_compatible_images.Options) !list_compatible_images.ListCompatibleImagesOutput {
        return list_compatible_images.execute(self, allocator, input, options);
    }

    /// Returns an array of `JobListEntry` objects of the specified length. Each
    /// `JobListEntry` object contains a job's state, a job's ID, and a value that
    /// indicates whether the job is a job part, in the case of export jobs. Calling
    /// this API action
    /// in one of the US regions will return jobs from the list of all jobs
    /// associated with this
    /// account in all US regions.
    pub fn listJobs(self: *Self, allocator: std.mem.Allocator, input: list_jobs.ListJobsInput, options: list_jobs.Options) !list_jobs.ListJobsOutput {
        return list_jobs.execute(self, allocator, input, options);
    }

    /// Lists all long-term pricing types.
    pub fn listLongTermPricing(self: *Self, allocator: std.mem.Allocator, input: list_long_term_pricing.ListLongTermPricingInput, options: list_long_term_pricing.Options) !list_long_term_pricing.ListLongTermPricingOutput {
        return list_long_term_pricing.execute(self, allocator, input, options);
    }

    /// A list of locations from which the customer can choose to pickup a device.
    pub fn listPickupLocations(self: *Self, allocator: std.mem.Allocator, input: list_pickup_locations.ListPickupLocationsInput, options: list_pickup_locations.Options) !list_pickup_locations.ListPickupLocationsOutput {
        return list_pickup_locations.execute(self, allocator, input, options);
    }

    /// Lists all supported versions for Snow on-device services. Returns an
    /// array of `ServiceVersion` object containing the supported versions for a
    /// particular service.
    pub fn listServiceVersions(self: *Self, allocator: std.mem.Allocator, input: list_service_versions.ListServiceVersionsInput, options: list_service_versions.Options) !list_service_versions.ListServiceVersionsOutput {
        return list_service_versions.execute(self, allocator, input, options);
    }

    /// While a cluster's `ClusterState` value is in the `AwaitingQuorum`
    /// state, you can update some of the information associated with a cluster.
    /// Once the cluster
    /// changes to a different job state, usually 60 minutes after the cluster being
    /// created, this
    /// action is no longer available.
    pub fn updateCluster(self: *Self, allocator: std.mem.Allocator, input: update_cluster.UpdateClusterInput, options: update_cluster.Options) !update_cluster.UpdateClusterOutput {
        return update_cluster.execute(self, allocator, input, options);
    }

    /// While a job's `JobState` value is `New`, you can update some of
    /// the information associated with a job. Once the job changes to a different
    /// job state, usually
    /// within 60 minutes of the job being created, this action is no longer
    /// available.
    pub fn updateJob(self: *Self, allocator: std.mem.Allocator, input: update_job.UpdateJobInput, options: update_job.Options) !update_job.UpdateJobOutput {
        return update_job.execute(self, allocator, input, options);
    }

    /// Updates the state when a shipment state changes to a different state.
    pub fn updateJobShipmentState(self: *Self, allocator: std.mem.Allocator, input: update_job_shipment_state.UpdateJobShipmentStateInput, options: update_job_shipment_state.Options) !update_job_shipment_state.UpdateJobShipmentStateOutput {
        return update_job_shipment_state.execute(self, allocator, input, options);
    }

    /// Updates the long-term pricing type.
    pub fn updateLongTermPricing(self: *Self, allocator: std.mem.Allocator, input: update_long_term_pricing.UpdateLongTermPricingInput, options: update_long_term_pricing.Options) !update_long_term_pricing.UpdateLongTermPricingOutput {
        return update_long_term_pricing.execute(self, allocator, input, options);
    }

    pub fn describeAddressesPaginator(self: *Self, params: describe_addresses.DescribeAddressesInput) paginator.DescribeAddressesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listClusterJobsPaginator(self: *Self, params: list_cluster_jobs.ListClusterJobsInput) paginator.ListClusterJobsPaginator {
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

    pub fn listCompatibleImagesPaginator(self: *Self, params: list_compatible_images.ListCompatibleImagesInput) paginator.ListCompatibleImagesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listJobsPaginator(self: *Self, params: list_jobs.ListJobsInput) paginator.ListJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listLongTermPricingPaginator(self: *Self, params: list_long_term_pricing.ListLongTermPricingInput) paginator.ListLongTermPricingPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPickupLocationsPaginator(self: *Self, params: list_pickup_locations.ListPickupLocationsInput) paginator.ListPickupLocationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
