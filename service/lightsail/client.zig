const aws = @import("aws");
const std = @import("std");

const allocate_static_ip = @import("allocate_static_ip.zig");
const attach_certificate_to_distribution = @import("attach_certificate_to_distribution.zig");
const attach_disk = @import("attach_disk.zig");
const attach_instances_to_load_balancer = @import("attach_instances_to_load_balancer.zig");
const attach_load_balancer_tls_certificate = @import("attach_load_balancer_tls_certificate.zig");
const attach_static_ip = @import("attach_static_ip.zig");
const close_instance_public_ports = @import("close_instance_public_ports.zig");
const copy_snapshot = @import("copy_snapshot.zig");
const create_bucket = @import("create_bucket.zig");
const create_bucket_access_key = @import("create_bucket_access_key.zig");
const create_certificate = @import("create_certificate.zig");
const create_cloud_formation_stack = @import("create_cloud_formation_stack.zig");
const create_contact_method = @import("create_contact_method.zig");
const create_container_service = @import("create_container_service.zig");
const create_container_service_deployment = @import("create_container_service_deployment.zig");
const create_container_service_registry_login = @import("create_container_service_registry_login.zig");
const create_disk = @import("create_disk.zig");
const create_disk_from_snapshot = @import("create_disk_from_snapshot.zig");
const create_disk_snapshot = @import("create_disk_snapshot.zig");
const create_distribution = @import("create_distribution.zig");
const create_domain = @import("create_domain.zig");
const create_domain_entry = @import("create_domain_entry.zig");
const create_gui_session_access_details = @import("create_gui_session_access_details.zig");
const create_instance_snapshot = @import("create_instance_snapshot.zig");
const create_instances = @import("create_instances.zig");
const create_instances_from_snapshot = @import("create_instances_from_snapshot.zig");
const create_key_pair = @import("create_key_pair.zig");
const create_load_balancer = @import("create_load_balancer.zig");
const create_load_balancer_tls_certificate = @import("create_load_balancer_tls_certificate.zig");
const create_relational_database = @import("create_relational_database.zig");
const create_relational_database_from_snapshot = @import("create_relational_database_from_snapshot.zig");
const create_relational_database_snapshot = @import("create_relational_database_snapshot.zig");
const delete_alarm = @import("delete_alarm.zig");
const delete_auto_snapshot = @import("delete_auto_snapshot.zig");
const delete_bucket = @import("delete_bucket.zig");
const delete_bucket_access_key = @import("delete_bucket_access_key.zig");
const delete_certificate = @import("delete_certificate.zig");
const delete_contact_method = @import("delete_contact_method.zig");
const delete_container_image = @import("delete_container_image.zig");
const delete_container_service = @import("delete_container_service.zig");
const delete_disk = @import("delete_disk.zig");
const delete_disk_snapshot = @import("delete_disk_snapshot.zig");
const delete_distribution = @import("delete_distribution.zig");
const delete_domain = @import("delete_domain.zig");
const delete_domain_entry = @import("delete_domain_entry.zig");
const delete_instance = @import("delete_instance.zig");
const delete_instance_snapshot = @import("delete_instance_snapshot.zig");
const delete_key_pair = @import("delete_key_pair.zig");
const delete_known_host_keys = @import("delete_known_host_keys.zig");
const delete_load_balancer = @import("delete_load_balancer.zig");
const delete_load_balancer_tls_certificate = @import("delete_load_balancer_tls_certificate.zig");
const delete_relational_database = @import("delete_relational_database.zig");
const delete_relational_database_snapshot = @import("delete_relational_database_snapshot.zig");
const detach_certificate_from_distribution = @import("detach_certificate_from_distribution.zig");
const detach_disk = @import("detach_disk.zig");
const detach_instances_from_load_balancer = @import("detach_instances_from_load_balancer.zig");
const detach_static_ip = @import("detach_static_ip.zig");
const disable_add_on = @import("disable_add_on.zig");
const download_default_key_pair = @import("download_default_key_pair.zig");
const enable_add_on = @import("enable_add_on.zig");
const export_snapshot = @import("export_snapshot.zig");
const get_active_names = @import("get_active_names.zig");
const get_alarms = @import("get_alarms.zig");
const get_auto_snapshots = @import("get_auto_snapshots.zig");
const get_blueprints = @import("get_blueprints.zig");
const get_bucket_access_keys = @import("get_bucket_access_keys.zig");
const get_bucket_bundles = @import("get_bucket_bundles.zig");
const get_bucket_metric_data = @import("get_bucket_metric_data.zig");
const get_buckets = @import("get_buckets.zig");
const get_bundles = @import("get_bundles.zig");
const get_certificates = @import("get_certificates.zig");
const get_cloud_formation_stack_records = @import("get_cloud_formation_stack_records.zig");
const get_contact_methods = @import("get_contact_methods.zig");
const get_container_api_metadata = @import("get_container_api_metadata.zig");
const get_container_images = @import("get_container_images.zig");
const get_container_log = @import("get_container_log.zig");
const get_container_service_deployments = @import("get_container_service_deployments.zig");
const get_container_service_metric_data = @import("get_container_service_metric_data.zig");
const get_container_service_powers = @import("get_container_service_powers.zig");
const get_container_services = @import("get_container_services.zig");
const get_cost_estimate = @import("get_cost_estimate.zig");
const get_disk = @import("get_disk.zig");
const get_disk_snapshot = @import("get_disk_snapshot.zig");
const get_disk_snapshots = @import("get_disk_snapshots.zig");
const get_disks = @import("get_disks.zig");
const get_distribution_bundles = @import("get_distribution_bundles.zig");
const get_distribution_latest_cache_reset = @import("get_distribution_latest_cache_reset.zig");
const get_distribution_metric_data = @import("get_distribution_metric_data.zig");
const get_distributions = @import("get_distributions.zig");
const get_domain = @import("get_domain.zig");
const get_domains = @import("get_domains.zig");
const get_export_snapshot_records = @import("get_export_snapshot_records.zig");
const get_instance = @import("get_instance.zig");
const get_instance_access_details = @import("get_instance_access_details.zig");
const get_instance_metric_data = @import("get_instance_metric_data.zig");
const get_instance_port_states = @import("get_instance_port_states.zig");
const get_instance_snapshot = @import("get_instance_snapshot.zig");
const get_instance_snapshots = @import("get_instance_snapshots.zig");
const get_instance_state = @import("get_instance_state.zig");
const get_instances = @import("get_instances.zig");
const get_key_pair = @import("get_key_pair.zig");
const get_key_pairs = @import("get_key_pairs.zig");
const get_load_balancer = @import("get_load_balancer.zig");
const get_load_balancer_metric_data = @import("get_load_balancer_metric_data.zig");
const get_load_balancer_tls_certificates = @import("get_load_balancer_tls_certificates.zig");
const get_load_balancer_tls_policies = @import("get_load_balancer_tls_policies.zig");
const get_load_balancers = @import("get_load_balancers.zig");
const get_operation = @import("get_operation.zig");
const get_operations = @import("get_operations.zig");
const get_operations_for_resource = @import("get_operations_for_resource.zig");
const get_regions = @import("get_regions.zig");
const get_relational_database = @import("get_relational_database.zig");
const get_relational_database_blueprints = @import("get_relational_database_blueprints.zig");
const get_relational_database_bundles = @import("get_relational_database_bundles.zig");
const get_relational_database_events = @import("get_relational_database_events.zig");
const get_relational_database_log_events = @import("get_relational_database_log_events.zig");
const get_relational_database_log_streams = @import("get_relational_database_log_streams.zig");
const get_relational_database_master_user_password = @import("get_relational_database_master_user_password.zig");
const get_relational_database_metric_data = @import("get_relational_database_metric_data.zig");
const get_relational_database_parameters = @import("get_relational_database_parameters.zig");
const get_relational_database_snapshot = @import("get_relational_database_snapshot.zig");
const get_relational_database_snapshots = @import("get_relational_database_snapshots.zig");
const get_relational_databases = @import("get_relational_databases.zig");
const get_setup_history = @import("get_setup_history.zig");
const get_static_ip = @import("get_static_ip.zig");
const get_static_ips = @import("get_static_ips.zig");
const import_key_pair = @import("import_key_pair.zig");
const is_vpc_peered = @import("is_vpc_peered.zig");
const open_instance_public_ports = @import("open_instance_public_ports.zig");
const peer_vpc = @import("peer_vpc.zig");
const put_alarm = @import("put_alarm.zig");
const put_instance_public_ports = @import("put_instance_public_ports.zig");
const reboot_instance = @import("reboot_instance.zig");
const reboot_relational_database = @import("reboot_relational_database.zig");
const register_container_image = @import("register_container_image.zig");
const release_static_ip = @import("release_static_ip.zig");
const reset_distribution_cache = @import("reset_distribution_cache.zig");
const send_contact_method_verification = @import("send_contact_method_verification.zig");
const set_ip_address_type = @import("set_ip_address_type.zig");
const set_resource_access_for_bucket = @import("set_resource_access_for_bucket.zig");
const setup_instance_https = @import("setup_instance_https.zig");
const start_gui_session = @import("start_gui_session.zig");
const start_instance = @import("start_instance.zig");
const start_relational_database = @import("start_relational_database.zig");
const stop_gui_session = @import("stop_gui_session.zig");
const stop_instance = @import("stop_instance.zig");
const stop_relational_database = @import("stop_relational_database.zig");
const tag_resource = @import("tag_resource.zig");
const test_alarm = @import("test_alarm.zig");
const unpeer_vpc = @import("unpeer_vpc.zig");
const untag_resource = @import("untag_resource.zig");
const update_bucket = @import("update_bucket.zig");
const update_bucket_bundle = @import("update_bucket_bundle.zig");
const update_container_service = @import("update_container_service.zig");
const update_distribution = @import("update_distribution.zig");
const update_distribution_bundle = @import("update_distribution_bundle.zig");
const update_domain_entry = @import("update_domain_entry.zig");
const update_instance_metadata_options = @import("update_instance_metadata_options.zig");
const update_load_balancer_attribute = @import("update_load_balancer_attribute.zig");
const update_relational_database = @import("update_relational_database.zig");
const update_relational_database_parameters = @import("update_relational_database_parameters.zig");
const CallOptions = @import("call_options.zig").CallOptions;

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Lightsail";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Allocates a static IP address.
    pub fn allocateStaticIp(self: *Self, allocator: std.mem.Allocator, input: allocate_static_ip.AllocateStaticIpInput, options: CallOptions) !allocate_static_ip.AllocateStaticIpOutput {
        return allocate_static_ip.execute(self, allocator, input, options);
    }

    /// Attaches an SSL/TLS certificate to your Amazon Lightsail content delivery
    /// network (CDN)
    /// distribution.
    ///
    /// After the certificate is attached, your distribution accepts HTTPS traffic
    /// for all of the
    /// domains that are associated with the certificate.
    ///
    /// Use the `CreateCertificate` action to create a certificate that you can
    /// attach
    /// to your distribution.
    ///
    /// Only certificates created in the `us-east-1`
    /// Amazon Web Services Region can be attached to Lightsail distributions.
    /// Lightsail
    /// distributions are global resources that can reference an origin in any
    /// Amazon Web Services
    /// Region, and distribute its content globally. However, all distributions are
    /// located in the
    /// `us-east-1` Region.
    pub fn attachCertificateToDistribution(self: *Self, allocator: std.mem.Allocator, input: attach_certificate_to_distribution.AttachCertificateToDistributionInput, options: CallOptions) !attach_certificate_to_distribution.AttachCertificateToDistributionOutput {
        return attach_certificate_to_distribution.execute(self, allocator, input, options);
    }

    /// Attaches a block storage disk to a running or stopped Lightsail instance and
    /// exposes it
    /// to the instance with the specified disk name.
    ///
    /// The `attach disk` operation supports tag-based access control via resource
    /// tags
    /// applied to the resource identified by `disk name`. For more information, see
    /// the
    /// [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn attachDisk(self: *Self, allocator: std.mem.Allocator, input: attach_disk.AttachDiskInput, options: CallOptions) !attach_disk.AttachDiskOutput {
        return attach_disk.execute(self, allocator, input, options);
    }

    /// Attaches one or more Lightsail instances to a load balancer.
    ///
    /// After some time, the instances are attached to the load balancer and the
    /// health check
    /// status is available.
    ///
    /// The `attach instances to load balancer` operation supports tag-based access
    /// control via resource tags applied to the resource identified by `load
    /// balancer
    /// name`. For more information, see the [Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn attachInstancesToLoadBalancer(self: *Self, allocator: std.mem.Allocator, input: attach_instances_to_load_balancer.AttachInstancesToLoadBalancerInput, options: CallOptions) !attach_instances_to_load_balancer.AttachInstancesToLoadBalancerOutput {
        return attach_instances_to_load_balancer.execute(self, allocator, input, options);
    }

    /// Attaches a Transport Layer Security (TLS) certificate to your load balancer.
    /// TLS is just
    /// an updated, more secure version of Secure Socket Layer (SSL).
    ///
    /// Once you create and validate your certificate, you can attach it to your
    /// load balancer.
    /// You can also use this API to rotate the certificates on your account. Use
    /// the
    /// `AttachLoadBalancerTlsCertificate` action with the non-attached certificate,
    /// and
    /// it will replace the existing one and become the attached certificate.
    ///
    /// The `AttachLoadBalancerTlsCertificate` operation supports tag-based access
    /// control via resource tags applied to the resource identified by `load
    /// balancer
    /// name`. For more information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn attachLoadBalancerTlsCertificate(self: *Self, allocator: std.mem.Allocator, input: attach_load_balancer_tls_certificate.AttachLoadBalancerTlsCertificateInput, options: CallOptions) !attach_load_balancer_tls_certificate.AttachLoadBalancerTlsCertificateOutput {
        return attach_load_balancer_tls_certificate.execute(self, allocator, input, options);
    }

    /// Attaches a static IP address to a specific Amazon Lightsail instance.
    pub fn attachStaticIp(self: *Self, allocator: std.mem.Allocator, input: attach_static_ip.AttachStaticIpInput, options: CallOptions) !attach_static_ip.AttachStaticIpOutput {
        return attach_static_ip.execute(self, allocator, input, options);
    }

    /// Closes ports for a specific Amazon Lightsail instance.
    ///
    /// The `CloseInstancePublicPorts` action supports tag-based access control via
    /// resource tags applied to the resource identified by `instanceName`. For more
    /// information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn closeInstancePublicPorts(self: *Self, allocator: std.mem.Allocator, input: close_instance_public_ports.CloseInstancePublicPortsInput, options: CallOptions) !close_instance_public_ports.CloseInstancePublicPortsOutput {
        return close_instance_public_ports.execute(self, allocator, input, options);
    }

    /// Copies a manual snapshot of an instance or disk as another manual snapshot,
    /// or copies an
    /// automatic snapshot of an instance or disk as a manual snapshot. This
    /// operation can also be
    /// used to copy a manual or automatic snapshot of an instance or a disk from
    /// one Amazon Web Services Region to another in Amazon Lightsail.
    ///
    /// When copying a *manual snapshot*, be sure to define the `source
    /// region`, `source snapshot name`, and `target snapshot name`
    /// parameters.
    ///
    /// When copying an *automatic snapshot*, be sure to define the
    /// `source region`, `source resource name`, `target snapshot
    /// name`, and either the `restore date` or the `use latest restorable
    /// auto snapshot` parameters.
    pub fn copySnapshot(self: *Self, allocator: std.mem.Allocator, input: copy_snapshot.CopySnapshotInput, options: CallOptions) !copy_snapshot.CopySnapshotOutput {
        return copy_snapshot.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Lightsail bucket.
    ///
    /// A bucket is a cloud storage resource available in the Lightsail object
    /// storage service.
    /// Use buckets to store objects such as data and its descriptive metadata. For
    /// more information
    /// about buckets, see [Buckets in Amazon
    /// Lightsail](https://docs.aws.amazon.com/lightsail/latest/userguide/buckets-in-amazon-lightsail) in the *Amazon Lightsail Developer
    /// Guide*.
    pub fn createBucket(self: *Self, allocator: std.mem.Allocator, input: create_bucket.CreateBucketInput, options: CallOptions) !create_bucket.CreateBucketOutput {
        return create_bucket.execute(self, allocator, input, options);
    }

    /// Creates a new access key for the specified Amazon Lightsail bucket. Access
    /// keys consist of
    /// an access key ID and corresponding secret access key.
    ///
    /// Access keys grant full programmatic access to the specified bucket and its
    /// objects. You
    /// can have a maximum of two access keys per bucket. Use the
    /// [GetBucketAccessKeys](https://docs.aws.amazon.com/lightsail/2016-11-28/api-reference/API_GetBucketAccessKeys.html) action to get a list of current access keys for a specific bucket. For more
    /// information about access keys, see [Creating access keys for a bucket in
    /// Amazon
    /// Lightsail](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-creating-bucket-access-keys) in the
    /// *Amazon Lightsail Developer Guide*.
    ///
    /// The `secretAccessKey` value is returned only in response to the
    /// `CreateBucketAccessKey` action. You can get a secret access key only when
    /// you
    /// first create an access key; you cannot get the secret access key later. If
    /// you lose the
    /// secret access key, you must create a new access key.
    pub fn createBucketAccessKey(self: *Self, allocator: std.mem.Allocator, input: create_bucket_access_key.CreateBucketAccessKeyInput, options: CallOptions) !create_bucket_access_key.CreateBucketAccessKeyOutput {
        return create_bucket_access_key.execute(self, allocator, input, options);
    }

    /// Creates an SSL/TLS certificate for an Amazon Lightsail content delivery
    /// network (CDN)
    /// distribution and a container service.
    ///
    /// After the certificate is valid, use the `AttachCertificateToDistribution`
    /// action to use the certificate and its domains with your distribution. Or use
    /// the
    /// `UpdateContainerService` action to use the certificate and its domains with
    /// your
    /// container service.
    ///
    /// Only certificates created in the `us-east-1`
    /// Amazon Web Services Region can be attached to Lightsail distributions.
    /// Lightsail
    /// distributions are global resources that can reference an origin in any
    /// Amazon Web Services
    /// Region, and distribute its content globally. However, all distributions are
    /// located in the
    /// `us-east-1` Region.
    pub fn createCertificate(self: *Self, allocator: std.mem.Allocator, input: create_certificate.CreateCertificateInput, options: CallOptions) !create_certificate.CreateCertificateOutput {
        return create_certificate.execute(self, allocator, input, options);
    }

    /// Creates an AWS CloudFormation stack, which creates a new Amazon EC2 instance
    /// from an exported
    /// Amazon Lightsail snapshot. This operation results in a CloudFormation stack
    /// record that can be
    /// used to track the AWS CloudFormation stack created. Use the `get cloud
    /// formation stack
    /// records` operation to get a list of the CloudFormation stacks created.
    ///
    /// Wait until after your new Amazon EC2 instance is created before running the
    /// `create
    /// cloud formation stack` operation again with the same export snapshot record.
    pub fn createCloudFormationStack(self: *Self, allocator: std.mem.Allocator, input: create_cloud_formation_stack.CreateCloudFormationStackInput, options: CallOptions) !create_cloud_formation_stack.CreateCloudFormationStackOutput {
        return create_cloud_formation_stack.execute(self, allocator, input, options);
    }

    /// Creates an email or SMS text message contact method.
    ///
    /// A contact method is used to send you notifications about your Amazon
    /// Lightsail resources.
    /// You can add one email address and one mobile phone number contact method in
    /// each Amazon Web Services Region. However, SMS text messaging is not
    /// supported in some Amazon Web Services
    /// Regions, and SMS text messages cannot be sent to some countries/regions. For
    /// more information,
    /// see [Notifications in Amazon
    /// Lightsail](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-notifications).
    ///
    /// The `create contact method` operation supports tag-based access control via
    /// request
    /// tags. For more information, see the [Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn createContactMethod(self: *Self, allocator: std.mem.Allocator, input: create_contact_method.CreateContactMethodInput, options: CallOptions) !create_contact_method.CreateContactMethodOutput {
        return create_contact_method.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Lightsail container service.
    ///
    /// A Lightsail container service is a compute resource to which you can deploy
    /// containers.
    /// For more information, see [Container services in Amazon
    /// Lightsail](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-container-services) in the *Lightsail Dev
    /// Guide*.
    pub fn createContainerService(self: *Self, allocator: std.mem.Allocator, input: create_container_service.CreateContainerServiceInput, options: CallOptions) !create_container_service.CreateContainerServiceOutput {
        return create_container_service.execute(self, allocator, input, options);
    }

    /// Creates a deployment for your Amazon Lightsail container service.
    ///
    /// A deployment specifies the containers that will be launched on the container
    /// service and
    /// their settings, such as the ports to open, the environment variables to
    /// apply, and the launch
    /// command to run. It also specifies the container that will serve as the
    /// public endpoint of the
    /// deployment and its settings, such as the HTTP or HTTPS port to use, and the
    /// health check
    /// configuration.
    ///
    /// You can deploy containers to your container service using container images
    /// from a public
    /// registry such as Amazon ECR Public, or from your local machine. For more
    /// information, see
    /// [Creating container images for your Amazon Lightsail container
    /// services](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-creating-container-images) in the
    /// *Amazon Lightsail Developer Guide*.
    pub fn createContainerServiceDeployment(self: *Self, allocator: std.mem.Allocator, input: create_container_service_deployment.CreateContainerServiceDeploymentInput, options: CallOptions) !create_container_service_deployment.CreateContainerServiceDeploymentOutput {
        return create_container_service_deployment.execute(self, allocator, input, options);
    }

    /// Creates a temporary set of log in credentials that you can use to log in to
    /// the Docker
    /// process on your local machine. After you're logged in, you can use the
    /// native Docker commands
    /// to push your local container images to the container image registry of your
    /// Amazon Lightsail
    /// account so that you can use them with your Lightsail container service. The
    /// log in
    /// credentials expire 12 hours after they are created, at which point you will
    /// need to create a
    /// new set of log in credentials.
    ///
    /// You can only push container images to the container service registry of your
    /// Lightsail
    /// account. You cannot pull container images or perform any other container
    /// image management
    /// actions on the container service registry.
    ///
    /// After you push your container images to the container image registry of your
    /// Lightsail
    /// account, use the `RegisterContainerImage` action to register the pushed
    /// images to a
    /// specific Lightsail container service.
    ///
    /// This action is not required if you install and use the Lightsail Control
    /// (lightsailctl) plugin to push container images to your Lightsail container
    /// service. For
    /// more information, see [Pushing and managing container images on your Amazon
    /// Lightsail container
    /// services](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-pushing-container-images)
    /// in the *Amazon Lightsail Developer Guide*.
    pub fn createContainerServiceRegistryLogin(self: *Self, allocator: std.mem.Allocator, input: create_container_service_registry_login.CreateContainerServiceRegistryLoginInput, options: CallOptions) !create_container_service_registry_login.CreateContainerServiceRegistryLoginOutput {
        return create_container_service_registry_login.execute(self, allocator, input, options);
    }

    /// Creates a block storage disk that can be attached to an Amazon Lightsail
    /// instance in the
    /// same Availability Zone (`us-east-2a`).
    ///
    /// The `create disk` operation supports tag-based access control via request
    /// tags.
    /// For more information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn createDisk(self: *Self, allocator: std.mem.Allocator, input: create_disk.CreateDiskInput, options: CallOptions) !create_disk.CreateDiskOutput {
        return create_disk.execute(self, allocator, input, options);
    }

    /// Creates a block storage disk from a manual or automatic snapshot of a disk.
    /// The resulting
    /// disk can be attached to an Amazon Lightsail instance in the same
    /// Availability Zone
    /// (`us-east-2a`).
    ///
    /// The `create disk from snapshot` operation supports tag-based access control
    /// via
    /// request tags and resource tags applied to the resource identified by `disk
    /// snapshot
    /// name`. For more information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn createDiskFromSnapshot(self: *Self, allocator: std.mem.Allocator, input: create_disk_from_snapshot.CreateDiskFromSnapshotInput, options: CallOptions) !create_disk_from_snapshot.CreateDiskFromSnapshotOutput {
        return create_disk_from_snapshot.execute(self, allocator, input, options);
    }

    /// Creates a snapshot of a block storage disk. You can use snapshots for
    /// backups, to make
    /// copies of disks, and to save data before shutting down a Lightsail instance.
    ///
    /// You can take a snapshot of an attached disk that is in use; however,
    /// snapshots only
    /// capture data that has been written to your disk at the time the snapshot
    /// command is issued.
    /// This may exclude any data that has been cached by any applications or the
    /// operating system. If
    /// you can pause any file systems on the disk long enough to take a snapshot,
    /// your snapshot
    /// should be complete. Nevertheless, if you cannot pause all file writes to the
    /// disk, you should
    /// unmount the disk from within the Lightsail instance, issue the create disk
    /// snapshot command,
    /// and then remount the disk to ensure a consistent and complete snapshot. You
    /// may remount and
    /// use your disk while the snapshot status is pending.
    ///
    /// You can also use this operation to create a snapshot of an instance's system
    /// volume. You
    /// might want to do this, for example, to recover data from the system volume
    /// of a botched
    /// instance or to create a backup of the system volume like you would for a
    /// block storage disk.
    /// To create a snapshot of a system volume, just define the `instance name`
    /// parameter
    /// when issuing the snapshot command, and a snapshot of the defined instance's
    /// system volume will
    /// be created. After the snapshot is available, you can create a block storage
    /// disk from the
    /// snapshot and attach it to a running instance to access the data on the disk.
    ///
    /// The `create disk snapshot` operation supports tag-based access control via
    /// request tags. For more information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn createDiskSnapshot(self: *Self, allocator: std.mem.Allocator, input: create_disk_snapshot.CreateDiskSnapshotInput, options: CallOptions) !create_disk_snapshot.CreateDiskSnapshotOutput {
        return create_disk_snapshot.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Lightsail content delivery network (CDN) distribution.
    ///
    /// A distribution is a globally distributed network of caching servers that
    /// improve the
    /// performance of your website or web application hosted on a Lightsail
    /// instance. For more
    /// information, see [Content delivery networks in Amazon
    /// Lightsail](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-content-delivery-network-distributions).
    pub fn createDistribution(self: *Self, allocator: std.mem.Allocator, input: create_distribution.CreateDistributionInput, options: CallOptions) !create_distribution.CreateDistributionOutput {
        return create_distribution.execute(self, allocator, input, options);
    }

    /// Creates a domain resource for the specified domain (example.com).
    ///
    /// The `create domain` operation supports tag-based access control via request
    /// tags. For more information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn createDomain(self: *Self, allocator: std.mem.Allocator, input: create_domain.CreateDomainInput, options: CallOptions) !create_domain.CreateDomainOutput {
        return create_domain.execute(self, allocator, input, options);
    }

    /// Creates one of the following domain name system (DNS) records in a domain
    /// DNS zone:
    /// Address (A), canonical name (CNAME), mail exchanger (MX), name server (NS),
    /// start of authority
    /// (SOA), service locator (SRV), or text (TXT).
    ///
    /// The `create domain entry` operation supports tag-based access control via
    /// resource tags applied to the resource identified by `domain name`. For more
    /// information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn createDomainEntry(self: *Self, allocator: std.mem.Allocator, input: create_domain_entry.CreateDomainEntryInput, options: CallOptions) !create_domain_entry.CreateDomainEntryOutput {
        return create_domain_entry.execute(self, allocator, input, options);
    }

    /// Creates two URLs that are used to access a virtual computer’s graphical user
    /// interface
    /// (GUI) session. The primary URL initiates a web-based Amazon DCV session to
    /// the virtual
    /// computer's application. The secondary URL initiates a web-based Amazon DCV
    /// session to the
    /// virtual computer's operating session.
    ///
    /// Use `StartGUISession` to open the session.
    pub fn createGuiSessionAccessDetails(self: *Self, allocator: std.mem.Allocator, input: create_gui_session_access_details.CreateGUISessionAccessDetailsInput, options: CallOptions) !create_gui_session_access_details.CreateGUISessionAccessDetailsOutput {
        return create_gui_session_access_details.execute(self, allocator, input, options);
    }

    /// Creates a snapshot of a specific virtual private server, or *instance*.
    /// You can use a snapshot to create a new instance that is based on that
    /// snapshot.
    ///
    /// The `create instance snapshot` operation supports tag-based access control
    /// via
    /// request tags. For more information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn createInstanceSnapshot(self: *Self, allocator: std.mem.Allocator, input: create_instance_snapshot.CreateInstanceSnapshotInput, options: CallOptions) !create_instance_snapshot.CreateInstanceSnapshotOutput {
        return create_instance_snapshot.execute(self, allocator, input, options);
    }

    /// Creates one or more Amazon Lightsail instances.
    ///
    /// The `create instances` operation supports tag-based access control via
    /// request
    /// tags. For more information, see the [Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn createInstances(self: *Self, allocator: std.mem.Allocator, input: create_instances.CreateInstancesInput, options: CallOptions) !create_instances.CreateInstancesOutput {
        return create_instances.execute(self, allocator, input, options);
    }

    /// Creates one or more new instances from a manual or automatic snapshot of an
    /// instance.
    ///
    /// The `create instances from snapshot` operation supports tag-based access
    /// control via request tags and resource tags applied to the resource
    /// identified by
    /// `instance snapshot name`. For more information, see the [Amazon Lightsail
    /// Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn createInstancesFromSnapshot(self: *Self, allocator: std.mem.Allocator, input: create_instances_from_snapshot.CreateInstancesFromSnapshotInput, options: CallOptions) !create_instances_from_snapshot.CreateInstancesFromSnapshotOutput {
        return create_instances_from_snapshot.execute(self, allocator, input, options);
    }

    /// Creates a custom SSH key pair that you can use with an Amazon Lightsail
    /// instance.
    ///
    /// Use the
    /// [DownloadDefaultKeyPair](https://docs.aws.amazon.com/lightsail/2016-11-28/api-reference/API_DownloadDefaultKeyPair.html) action to create a Lightsail default key
    /// pair in an Amazon Web Services Region where a default key pair does not
    /// currently
    /// exist.
    ///
    /// The `create key pair` operation supports tag-based access control via
    /// request
    /// tags. For more information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn createKeyPair(self: *Self, allocator: std.mem.Allocator, input: create_key_pair.CreateKeyPairInput, options: CallOptions) !create_key_pair.CreateKeyPairOutput {
        return create_key_pair.execute(self, allocator, input, options);
    }

    /// Creates a Lightsail load balancer. To learn more about deciding whether to
    /// load balance
    /// your application, see [Configure your Lightsail instances for load
    /// balancing](https://docs.aws.amazon.com/lightsail/latest/userguide/configure-lightsail-instances-for-load-balancing). You can create up to 10
    /// load balancers per AWS Region in your account.
    ///
    /// When you create a load balancer, you can specify a unique name and port
    /// settings. To
    /// change additional load balancer settings, use the
    /// `UpdateLoadBalancerAttribute`
    /// operation.
    ///
    /// The `create load balancer` operation supports tag-based access control via
    /// request tags. For more information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn createLoadBalancer(self: *Self, allocator: std.mem.Allocator, input: create_load_balancer.CreateLoadBalancerInput, options: CallOptions) !create_load_balancer.CreateLoadBalancerOutput {
        return create_load_balancer.execute(self, allocator, input, options);
    }

    /// Creates an SSL/TLS certificate for an Amazon Lightsail load balancer.
    ///
    /// TLS is just an updated, more secure version of Secure Socket Layer (SSL).
    ///
    /// The `CreateLoadBalancerTlsCertificate` operation supports tag-based access
    /// control via resource tags applied to the resource identified by `load
    /// balancer
    /// name`. For more information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn createLoadBalancerTlsCertificate(self: *Self, allocator: std.mem.Allocator, input: create_load_balancer_tls_certificate.CreateLoadBalancerTlsCertificateInput, options: CallOptions) !create_load_balancer_tls_certificate.CreateLoadBalancerTlsCertificateOutput {
        return create_load_balancer_tls_certificate.execute(self, allocator, input, options);
    }

    /// Creates a new database in Amazon Lightsail.
    ///
    /// The `create relational database` operation supports tag-based access control
    /// via request tags. For more information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn createRelationalDatabase(self: *Self, allocator: std.mem.Allocator, input: create_relational_database.CreateRelationalDatabaseInput, options: CallOptions) !create_relational_database.CreateRelationalDatabaseOutput {
        return create_relational_database.execute(self, allocator, input, options);
    }

    /// Creates a new database from an existing database snapshot in Amazon
    /// Lightsail.
    ///
    /// You can create a new database from a snapshot in if something goes wrong
    /// with your
    /// original database, or to change it to a different plan, such as a high
    /// availability or
    /// standard plan.
    ///
    /// The `create relational database from snapshot` operation supports tag-based
    /// access control via request tags and resource tags applied to the resource
    /// identified by
    /// relationalDatabaseSnapshotName. For more information, see the [Amazon
    /// Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn createRelationalDatabaseFromSnapshot(self: *Self, allocator: std.mem.Allocator, input: create_relational_database_from_snapshot.CreateRelationalDatabaseFromSnapshotInput, options: CallOptions) !create_relational_database_from_snapshot.CreateRelationalDatabaseFromSnapshotOutput {
        return create_relational_database_from_snapshot.execute(self, allocator, input, options);
    }

    /// Creates a snapshot of your database in Amazon Lightsail. You can use
    /// snapshots for backups,
    /// to make copies of a database, and to save data before deleting a database.
    ///
    /// The `create relational database snapshot` operation supports tag-based
    /// access
    /// control via request tags. For more information, see the [Amazon Lightsail
    /// Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn createRelationalDatabaseSnapshot(self: *Self, allocator: std.mem.Allocator, input: create_relational_database_snapshot.CreateRelationalDatabaseSnapshotInput, options: CallOptions) !create_relational_database_snapshot.CreateRelationalDatabaseSnapshotOutput {
        return create_relational_database_snapshot.execute(self, allocator, input, options);
    }

    /// Deletes an alarm.
    ///
    /// An alarm is used to monitor a single metric for one of your resources. When
    /// a metric
    /// condition is met, the alarm can notify you by email, SMS text message, and a
    /// banner displayed
    /// on the Amazon Lightsail console. For more information, see [Alarms
    /// in Amazon
    /// Lightsail](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-alarms).
    pub fn deleteAlarm(self: *Self, allocator: std.mem.Allocator, input: delete_alarm.DeleteAlarmInput, options: CallOptions) !delete_alarm.DeleteAlarmOutput {
        return delete_alarm.execute(self, allocator, input, options);
    }

    /// Deletes an automatic snapshot of an instance or disk. For more information,
    /// see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-configuring-automatic-snapshots).
    pub fn deleteAutoSnapshot(self: *Self, allocator: std.mem.Allocator, input: delete_auto_snapshot.DeleteAutoSnapshotInput, options: CallOptions) !delete_auto_snapshot.DeleteAutoSnapshotOutput {
        return delete_auto_snapshot.execute(self, allocator, input, options);
    }

    /// Deletes a Amazon Lightsail bucket.
    ///
    /// When you delete your bucket, the bucket name is released and can be reused
    /// for a new
    /// bucket in your account or another Amazon Web Services account.
    pub fn deleteBucket(self: *Self, allocator: std.mem.Allocator, input: delete_bucket.DeleteBucketInput, options: CallOptions) !delete_bucket.DeleteBucketOutput {
        return delete_bucket.execute(self, allocator, input, options);
    }

    /// Deletes an access key for the specified Amazon Lightsail bucket.
    ///
    /// We recommend that you delete an access key if the secret access key is
    /// compromised.
    ///
    /// For more information about access keys, see [Creating access keys for a
    /// bucket in Amazon
    /// Lightsail](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-creating-bucket-access-keys) in the
    /// *Amazon Lightsail Developer Guide*.
    pub fn deleteBucketAccessKey(self: *Self, allocator: std.mem.Allocator, input: delete_bucket_access_key.DeleteBucketAccessKeyInput, options: CallOptions) !delete_bucket_access_key.DeleteBucketAccessKeyOutput {
        return delete_bucket_access_key.execute(self, allocator, input, options);
    }

    /// Deletes an SSL/TLS certificate for your Amazon Lightsail content delivery
    /// network (CDN)
    /// distribution.
    ///
    /// Certificates that are currently attached to a distribution cannot be
    /// deleted. Use the
    /// `DetachCertificateFromDistribution` action to detach a certificate from a
    /// distribution.
    pub fn deleteCertificate(self: *Self, allocator: std.mem.Allocator, input: delete_certificate.DeleteCertificateInput, options: CallOptions) !delete_certificate.DeleteCertificateOutput {
        return delete_certificate.execute(self, allocator, input, options);
    }

    /// Deletes a contact method.
    ///
    /// A contact method is used to send you notifications about your Amazon
    /// Lightsail resources.
    /// You can add one email address and one mobile phone number contact method in
    /// each Amazon Web Services Region. However, SMS text messaging is not
    /// supported in some Amazon Web Services
    /// Regions, and SMS text messages cannot be sent to some countries/regions. For
    /// more information,
    /// see [Notifications in Amazon
    /// Lightsail](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-notifications).
    pub fn deleteContactMethod(self: *Self, allocator: std.mem.Allocator, input: delete_contact_method.DeleteContactMethodInput, options: CallOptions) !delete_contact_method.DeleteContactMethodOutput {
        return delete_contact_method.execute(self, allocator, input, options);
    }

    /// Deletes a container image that is registered to your Amazon Lightsail
    /// container
    /// service.
    pub fn deleteContainerImage(self: *Self, allocator: std.mem.Allocator, input: delete_container_image.DeleteContainerImageInput, options: CallOptions) !delete_container_image.DeleteContainerImageOutput {
        return delete_container_image.execute(self, allocator, input, options);
    }

    /// Deletes your Amazon Lightsail container service.
    pub fn deleteContainerService(self: *Self, allocator: std.mem.Allocator, input: delete_container_service.DeleteContainerServiceInput, options: CallOptions) !delete_container_service.DeleteContainerServiceOutput {
        return delete_container_service.execute(self, allocator, input, options);
    }

    /// Deletes the specified block storage disk. The disk must be in the
    /// `available`
    /// state (not attached to a Lightsail instance).
    ///
    /// The disk may remain in the `deleting` state for several minutes.
    ///
    /// The `delete disk` operation supports tag-based access control via resource
    /// tags
    /// applied to the resource identified by `disk name`. For more information, see
    /// the
    /// [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn deleteDisk(self: *Self, allocator: std.mem.Allocator, input: delete_disk.DeleteDiskInput, options: CallOptions) !delete_disk.DeleteDiskOutput {
        return delete_disk.execute(self, allocator, input, options);
    }

    /// Deletes the specified disk snapshot.
    ///
    /// When you make periodic snapshots of a disk, the snapshots are incremental,
    /// and only the
    /// blocks on the device that have changed since your last snapshot are saved in
    /// the new snapshot.
    /// When you delete a snapshot, only the data not needed for any other snapshot
    /// is removed. So
    /// regardless of which prior snapshots have been deleted, all active snapshots
    /// will have access
    /// to all the information needed to restore the disk.
    ///
    /// The `delete disk snapshot` operation supports tag-based access control via
    /// resource tags applied to the resource identified by `disk snapshot name`.
    /// For more
    /// information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn deleteDiskSnapshot(self: *Self, allocator: std.mem.Allocator, input: delete_disk_snapshot.DeleteDiskSnapshotInput, options: CallOptions) !delete_disk_snapshot.DeleteDiskSnapshotOutput {
        return delete_disk_snapshot.execute(self, allocator, input, options);
    }

    /// Deletes your Amazon Lightsail content delivery network (CDN) distribution.
    pub fn deleteDistribution(self: *Self, allocator: std.mem.Allocator, input: delete_distribution.DeleteDistributionInput, options: CallOptions) !delete_distribution.DeleteDistributionOutput {
        return delete_distribution.execute(self, allocator, input, options);
    }

    /// Deletes the specified domain recordset and all of its domain records.
    ///
    /// The `delete domain` operation supports tag-based access control via resource
    /// tags applied to the resource identified by `domain name`. For more
    /// information, see
    /// the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn deleteDomain(self: *Self, allocator: std.mem.Allocator, input: delete_domain.DeleteDomainInput, options: CallOptions) !delete_domain.DeleteDomainOutput {
        return delete_domain.execute(self, allocator, input, options);
    }

    /// Deletes a specific domain entry.
    ///
    /// The `delete domain entry` operation supports tag-based access control via
    /// resource tags applied to the resource identified by `domain name`. For more
    /// information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn deleteDomainEntry(self: *Self, allocator: std.mem.Allocator, input: delete_domain_entry.DeleteDomainEntryInput, options: CallOptions) !delete_domain_entry.DeleteDomainEntryOutput {
        return delete_domain_entry.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Lightsail instance.
    ///
    /// The `delete instance` operation supports tag-based access control via
    /// resource
    /// tags applied to the resource identified by `instance name`. For more
    /// information,
    /// see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn deleteInstance(self: *Self, allocator: std.mem.Allocator, input: delete_instance.DeleteInstanceInput, options: CallOptions) !delete_instance.DeleteInstanceOutput {
        return delete_instance.execute(self, allocator, input, options);
    }

    /// Deletes a specific snapshot of a virtual private server (or
    /// *instance*).
    ///
    /// The `delete instance snapshot` operation supports tag-based access control
    /// via
    /// resource tags applied to the resource identified by `instance snapshot
    /// name`. For
    /// more information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn deleteInstanceSnapshot(self: *Self, allocator: std.mem.Allocator, input: delete_instance_snapshot.DeleteInstanceSnapshotInput, options: CallOptions) !delete_instance_snapshot.DeleteInstanceSnapshotOutput {
        return delete_instance_snapshot.execute(self, allocator, input, options);
    }

    /// Deletes the specified key pair by removing the public key from Amazon
    /// Lightsail.
    ///
    /// You can delete key pairs that were created using the
    /// [ImportKeyPair](https://docs.aws.amazon.com/lightsail/2016-11-28/api-reference/API_ImportKeyPair.html) and
    /// [CreateKeyPair](https://docs.aws.amazon.com/lightsail/2016-11-28/api-reference/API_CreateKeyPair.html) actions, as well as the Lightsail default key pair. A new default
    /// key pair will not be created unless you launch an instance without
    /// specifying a custom key
    /// pair, or you call the
    /// [DownloadDefaultKeyPair](https://docs.aws.amazon.com/lightsail/2016-11-28/api-reference/API_DownloadDefaultKeyPair.html) API.
    ///
    /// The `delete key pair` operation supports tag-based access control via
    /// resource
    /// tags applied to the resource identified by `key pair name`. For more
    /// information,
    /// see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn deleteKeyPair(self: *Self, allocator: std.mem.Allocator, input: delete_key_pair.DeleteKeyPairInput, options: CallOptions) !delete_key_pair.DeleteKeyPairOutput {
        return delete_key_pair.execute(self, allocator, input, options);
    }

    /// Deletes the known host key or certificate used by the Amazon Lightsail
    /// browser-based SSH or
    /// RDP clients to authenticate an instance. This operation enables the
    /// Lightsail browser-based
    /// SSH or RDP clients to connect to the instance after a host key mismatch.
    ///
    /// Perform this operation only if you were expecting the host key or
    /// certificate mismatch
    /// or if you are familiar with the new host key or certificate on the instance.
    /// For more
    /// information, see [Troubleshooting connection issues when using the Amazon
    /// Lightsail browser-based SSH or RDP
    /// client](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-troubleshooting-browser-based-ssh-rdp-client-connection).
    pub fn deleteKnownHostKeys(self: *Self, allocator: std.mem.Allocator, input: delete_known_host_keys.DeleteKnownHostKeysInput, options: CallOptions) !delete_known_host_keys.DeleteKnownHostKeysOutput {
        return delete_known_host_keys.execute(self, allocator, input, options);
    }

    /// Deletes a Lightsail load balancer and all its associated SSL/TLS
    /// certificates. Once the
    /// load balancer is deleted, you will need to create a new load balancer,
    /// create a new
    /// certificate, and verify domain ownership again.
    ///
    /// The `delete load balancer` operation supports tag-based access control via
    /// resource tags applied to the resource identified by `load balancer name`.
    /// For more
    /// information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn deleteLoadBalancer(self: *Self, allocator: std.mem.Allocator, input: delete_load_balancer.DeleteLoadBalancerInput, options: CallOptions) !delete_load_balancer.DeleteLoadBalancerOutput {
        return delete_load_balancer.execute(self, allocator, input, options);
    }

    /// Deletes an SSL/TLS certificate associated with a Lightsail load balancer.
    ///
    /// The `DeleteLoadBalancerTlsCertificate` operation supports tag-based access
    /// control via resource tags applied to the resource identified by `load
    /// balancer
    /// name`. For more information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn deleteLoadBalancerTlsCertificate(self: *Self, allocator: std.mem.Allocator, input: delete_load_balancer_tls_certificate.DeleteLoadBalancerTlsCertificateInput, options: CallOptions) !delete_load_balancer_tls_certificate.DeleteLoadBalancerTlsCertificateOutput {
        return delete_load_balancer_tls_certificate.execute(self, allocator, input, options);
    }

    /// Deletes a database in Amazon Lightsail.
    ///
    /// The `delete relational database` operation supports tag-based access control
    /// via resource tags applied to the resource identified by
    /// relationalDatabaseName. For more
    /// information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn deleteRelationalDatabase(self: *Self, allocator: std.mem.Allocator, input: delete_relational_database.DeleteRelationalDatabaseInput, options: CallOptions) !delete_relational_database.DeleteRelationalDatabaseOutput {
        return delete_relational_database.execute(self, allocator, input, options);
    }

    /// Deletes a database snapshot in Amazon Lightsail.
    ///
    /// The `delete relational database snapshot` operation supports tag-based
    /// access
    /// control via resource tags applied to the resource identified by
    /// relationalDatabaseName. For
    /// more information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn deleteRelationalDatabaseSnapshot(self: *Self, allocator: std.mem.Allocator, input: delete_relational_database_snapshot.DeleteRelationalDatabaseSnapshotInput, options: CallOptions) !delete_relational_database_snapshot.DeleteRelationalDatabaseSnapshotOutput {
        return delete_relational_database_snapshot.execute(self, allocator, input, options);
    }

    /// Detaches an SSL/TLS certificate from your Amazon Lightsail content delivery
    /// network (CDN)
    /// distribution.
    ///
    /// After the certificate is detached, your distribution stops accepting traffic
    /// for all of
    /// the domains that are associated with the certificate.
    pub fn detachCertificateFromDistribution(self: *Self, allocator: std.mem.Allocator, input: detach_certificate_from_distribution.DetachCertificateFromDistributionInput, options: CallOptions) !detach_certificate_from_distribution.DetachCertificateFromDistributionOutput {
        return detach_certificate_from_distribution.execute(self, allocator, input, options);
    }

    /// Detaches a stopped block storage disk from a Lightsail instance. Make sure
    /// to unmount
    /// any file systems on the device within your operating system before stopping
    /// the instance and
    /// detaching the disk.
    ///
    /// The `detach disk` operation supports tag-based access control via resource
    /// tags
    /// applied to the resource identified by `disk name`. For more information, see
    /// the
    /// [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn detachDisk(self: *Self, allocator: std.mem.Allocator, input: detach_disk.DetachDiskInput, options: CallOptions) !detach_disk.DetachDiskOutput {
        return detach_disk.execute(self, allocator, input, options);
    }

    /// Detaches the specified instances from a Lightsail load balancer.
    ///
    /// This operation waits until the instances are no longer needed before they
    /// are detached
    /// from the load balancer.
    ///
    /// The `detach instances from load balancer` operation supports tag-based
    /// access
    /// control via resource tags applied to the resource identified by `load
    /// balancer
    /// name`. For more information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn detachInstancesFromLoadBalancer(self: *Self, allocator: std.mem.Allocator, input: detach_instances_from_load_balancer.DetachInstancesFromLoadBalancerInput, options: CallOptions) !detach_instances_from_load_balancer.DetachInstancesFromLoadBalancerOutput {
        return detach_instances_from_load_balancer.execute(self, allocator, input, options);
    }

    /// Detaches a static IP from the Amazon Lightsail instance to which it is
    /// attached.
    pub fn detachStaticIp(self: *Self, allocator: std.mem.Allocator, input: detach_static_ip.DetachStaticIpInput, options: CallOptions) !detach_static_ip.DetachStaticIpOutput {
        return detach_static_ip.execute(self, allocator, input, options);
    }

    /// Disables an add-on for an Amazon Lightsail resource. For more information,
    /// see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-configuring-automatic-snapshots).
    pub fn disableAddOn(self: *Self, allocator: std.mem.Allocator, input: disable_add_on.DisableAddOnInput, options: CallOptions) !disable_add_on.DisableAddOnOutput {
        return disable_add_on.execute(self, allocator, input, options);
    }

    /// Downloads the regional Amazon Lightsail default key pair.
    ///
    /// This action also creates a Lightsail default key pair if a default key pair
    /// does not currently exist in the Amazon Web Services Region.
    pub fn downloadDefaultKeyPair(self: *Self, allocator: std.mem.Allocator, input: download_default_key_pair.DownloadDefaultKeyPairInput, options: CallOptions) !download_default_key_pair.DownloadDefaultKeyPairOutput {
        return download_default_key_pair.execute(self, allocator, input, options);
    }

    /// Enables or modifies an add-on for an Amazon Lightsail resource. For more
    /// information, see
    /// the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-configuring-automatic-snapshots).
    pub fn enableAddOn(self: *Self, allocator: std.mem.Allocator, input: enable_add_on.EnableAddOnInput, options: CallOptions) !enable_add_on.EnableAddOnOutput {
        return enable_add_on.execute(self, allocator, input, options);
    }

    /// Exports an Amazon Lightsail instance or block storage disk snapshot to
    /// Amazon Elastic Compute Cloud (Amazon EC2).
    /// This operation results in an export snapshot record that can be used with
    /// the `create
    /// cloud formation stack` operation to create new Amazon EC2 instances.
    ///
    /// Exported instance snapshots appear in Amazon EC2 as Amazon Machine Images
    /// (AMIs), and the
    /// instance system disk appears as an Amazon Elastic Block Store (Amazon EBS)
    /// volume. Exported disk snapshots appear in
    /// Amazon EC2 as Amazon EBS volumes. Snapshots are exported to the same Amazon
    /// Web Services Region in
    /// Amazon EC2 as the source Lightsail snapshot.
    ///
    /// The `export snapshot` operation supports tag-based access control via
    /// resource
    /// tags applied to the resource identified by `source snapshot name`. For more
    /// information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    ///
    /// Use the `get instance snapshots` or `get disk snapshots`
    /// operations to get a list of snapshots that you can export to Amazon EC2.
    pub fn exportSnapshot(self: *Self, allocator: std.mem.Allocator, input: export_snapshot.ExportSnapshotInput, options: CallOptions) !export_snapshot.ExportSnapshotOutput {
        return export_snapshot.execute(self, allocator, input, options);
    }

    /// Returns the names of all active (not deleted) resources.
    pub fn getActiveNames(self: *Self, allocator: std.mem.Allocator, input: get_active_names.GetActiveNamesInput, options: CallOptions) !get_active_names.GetActiveNamesOutput {
        return get_active_names.execute(self, allocator, input, options);
    }

    /// Returns information about the configured alarms. Specify an alarm name in
    /// your request to
    /// return information about a specific alarm, or specify a monitored resource
    /// name to return
    /// information about all alarms for a specific resource.
    ///
    /// An alarm is used to monitor a single metric for one of your resources. When
    /// a metric
    /// condition is met, the alarm can notify you by email, SMS text message, and a
    /// banner displayed
    /// on the Amazon Lightsail console. For more information, see [Alarms
    /// in Amazon
    /// Lightsail](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-alarms).
    pub fn getAlarms(self: *Self, allocator: std.mem.Allocator, input: get_alarms.GetAlarmsInput, options: CallOptions) !get_alarms.GetAlarmsOutput {
        return get_alarms.execute(self, allocator, input, options);
    }

    /// Returns the available automatic snapshots for an instance or disk. For more
    /// information,
    /// see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-configuring-automatic-snapshots).
    pub fn getAutoSnapshots(self: *Self, allocator: std.mem.Allocator, input: get_auto_snapshots.GetAutoSnapshotsInput, options: CallOptions) !get_auto_snapshots.GetAutoSnapshotsOutput {
        return get_auto_snapshots.execute(self, allocator, input, options);
    }

    /// Returns the list of available instance images, or *blueprints*. You can
    /// use a blueprint to create a new instance already running a specific
    /// operating system, as well
    /// as a preinstalled app or development stack. The software each instance is
    /// running depends on
    /// the blueprint image you choose.
    ///
    /// Use active blueprints when creating new instances. Inactive blueprints are
    /// listed to
    /// support customers with existing instances and are not necessarily available
    /// to create new
    /// instances. Blueprints are marked inactive when they become outdated due to
    /// operating system
    /// updates or new application releases.
    pub fn getBlueprints(self: *Self, allocator: std.mem.Allocator, input: get_blueprints.GetBlueprintsInput, options: CallOptions) !get_blueprints.GetBlueprintsOutput {
        return get_blueprints.execute(self, allocator, input, options);
    }

    /// Returns the existing access key IDs for the specified Amazon Lightsail
    /// bucket.
    ///
    /// This action does not return the secret access key value of an access key.
    /// You can get a
    /// secret access key only when you create it from the response of the
    /// [CreateBucketAccessKey](https://docs.aws.amazon.com/lightsail/2016-11-28/api-reference/API_CreateBucketAccessKey.html) action. If you lose the secret access key, you must create
    /// a new access key.
    pub fn getBucketAccessKeys(self: *Self, allocator: std.mem.Allocator, input: get_bucket_access_keys.GetBucketAccessKeysInput, options: CallOptions) !get_bucket_access_keys.GetBucketAccessKeysOutput {
        return get_bucket_access_keys.execute(self, allocator, input, options);
    }

    /// Returns the bundles that you can apply to a Amazon Lightsail bucket.
    ///
    /// The bucket bundle specifies the monthly cost, storage quota, and data
    /// transfer quota for a
    /// bucket.
    ///
    /// Use the
    /// [UpdateBucketBundle](https://docs.aws.amazon.com/lightsail/2016-11-28/api-reference/API_UpdateBucketBundle.html) action to update the
    /// bundle for a bucket.
    pub fn getBucketBundles(self: *Self, allocator: std.mem.Allocator, input: get_bucket_bundles.GetBucketBundlesInput, options: CallOptions) !get_bucket_bundles.GetBucketBundlesOutput {
        return get_bucket_bundles.execute(self, allocator, input, options);
    }

    /// Returns the data points of a specific metric for an Amazon Lightsail bucket.
    ///
    /// Metrics report the utilization of a bucket. View and collect metric data
    /// regularly to
    /// monitor the number of objects stored in a bucket (including object versions)
    /// and the storage
    /// space used by those objects.
    pub fn getBucketMetricData(self: *Self, allocator: std.mem.Allocator, input: get_bucket_metric_data.GetBucketMetricDataInput, options: CallOptions) !get_bucket_metric_data.GetBucketMetricDataOutput {
        return get_bucket_metric_data.execute(self, allocator, input, options);
    }

    /// Returns information about one or more Amazon Lightsail buckets. The
    /// information returned
    /// includes the synchronization status of the Amazon Simple Storage Service
    /// (Amazon S3)
    /// account-level block public access feature for your Lightsail buckets.
    ///
    /// For more information about buckets, see [Buckets in Amazon
    /// Lightsail](https://docs.aws.amazon.com/lightsail/latest/userguide/buckets-in-amazon-lightsail) in the *Amazon Lightsail Developer
    /// Guide*.
    pub fn getBuckets(self: *Self, allocator: std.mem.Allocator, input: get_buckets.GetBucketsInput, options: CallOptions) !get_buckets.GetBucketsOutput {
        return get_buckets.execute(self, allocator, input, options);
    }

    /// Returns the bundles that you can apply to an Amazon Lightsail instance when
    /// you create
    /// it.
    ///
    /// A bundle describes the specifications of an instance, such as the monthly
    /// cost, amount of
    /// memory, the number of vCPUs, amount of storage space, and monthly network
    /// data transfer
    /// quota.
    ///
    /// Bundles are referred to as *instance plans* in the Lightsail
    /// console.
    pub fn getBundles(self: *Self, allocator: std.mem.Allocator, input: get_bundles.GetBundlesInput, options: CallOptions) !get_bundles.GetBundlesOutput {
        return get_bundles.execute(self, allocator, input, options);
    }

    /// Returns information about one or more Amazon Lightsail SSL/TLS certificates.
    ///
    /// To get a summary of a certificate, omit `includeCertificateDetails` from
    /// your
    /// request. The response will include only the certificate Amazon Resource Name
    /// (ARN),
    /// certificate name, domain name, and tags.
    pub fn getCertificates(self: *Self, allocator: std.mem.Allocator, input: get_certificates.GetCertificatesInput, options: CallOptions) !get_certificates.GetCertificatesOutput {
        return get_certificates.execute(self, allocator, input, options);
    }

    /// Returns the CloudFormation stack record created as a result of the `create
    /// cloud
    /// formation stack` operation.
    ///
    /// An AWS CloudFormation stack is used to create a new Amazon EC2 instance from
    /// an exported Lightsail
    /// snapshot.
    pub fn getCloudFormationStackRecords(self: *Self, allocator: std.mem.Allocator, input: get_cloud_formation_stack_records.GetCloudFormationStackRecordsInput, options: CallOptions) !get_cloud_formation_stack_records.GetCloudFormationStackRecordsOutput {
        return get_cloud_formation_stack_records.execute(self, allocator, input, options);
    }

    /// Returns information about the configured contact methods. Specify a protocol
    /// in your
    /// request to return information about a specific contact method.
    ///
    /// A contact method is used to send you notifications about your Amazon
    /// Lightsail resources.
    /// You can add one email address and one mobile phone number contact method in
    /// each Amazon Web Services Region. However, SMS text messaging is not
    /// supported in some Amazon Web Services
    /// Regions, and SMS text messages cannot be sent to some countries/regions. For
    /// more information,
    /// see [Notifications in Amazon
    /// Lightsail](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-notifications).
    pub fn getContactMethods(self: *Self, allocator: std.mem.Allocator, input: get_contact_methods.GetContactMethodsInput, options: CallOptions) !get_contact_methods.GetContactMethodsOutput {
        return get_contact_methods.execute(self, allocator, input, options);
    }

    /// Returns information about Amazon Lightsail containers, such as the current
    /// version of the
    /// Lightsail Control (lightsailctl) plugin.
    pub fn getContainerApiMetadata(self: *Self, allocator: std.mem.Allocator, input: get_container_api_metadata.GetContainerAPIMetadataInput, options: CallOptions) !get_container_api_metadata.GetContainerAPIMetadataOutput {
        return get_container_api_metadata.execute(self, allocator, input, options);
    }

    /// Returns the container images that are registered to your Amazon Lightsail
    /// container
    /// service.
    ///
    /// If you created a deployment on your Lightsail container service that uses
    /// container
    /// images from a public registry like Docker Hub, those images are not returned
    /// as part of this
    /// action. Those images are not registered to your Lightsail container service.
    pub fn getContainerImages(self: *Self, allocator: std.mem.Allocator, input: get_container_images.GetContainerImagesInput, options: CallOptions) !get_container_images.GetContainerImagesOutput {
        return get_container_images.execute(self, allocator, input, options);
    }

    /// Returns the log events of a container of your Amazon Lightsail container
    /// service.
    ///
    /// If your container service has more than one node (i.e., a scale greater than
    /// 1), then the
    /// log events that are returned for the specified container are merged from all
    /// nodes on your
    /// container service.
    ///
    /// Container logs are retained for a certain amount of time. For more
    /// information, see
    /// [Amazon Lightsail
    /// endpoints and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/lightsail.html) in the
    /// *Amazon Web Services General
    /// Reference*.
    pub fn getContainerLog(self: *Self, allocator: std.mem.Allocator, input: get_container_log.GetContainerLogInput, options: CallOptions) !get_container_log.GetContainerLogOutput {
        return get_container_log.execute(self, allocator, input, options);
    }

    /// Returns the deployments for your Amazon Lightsail container service
    ///
    /// A deployment specifies the settings, such as the ports and launch command,
    /// of containers
    /// that are deployed to your container service.
    ///
    /// The deployments are ordered by version in ascending order. The newest
    /// version is listed at
    /// the top of the response.
    ///
    /// A set number of deployments are kept before the oldest one is replaced with
    /// the newest
    /// one. For more information, see [Amazon Lightsail
    /// endpoints and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/lightsail.html) in the
    /// *Amazon Web Services General
    /// Reference*.
    pub fn getContainerServiceDeployments(self: *Self, allocator: std.mem.Allocator, input: get_container_service_deployments.GetContainerServiceDeploymentsInput, options: CallOptions) !get_container_service_deployments.GetContainerServiceDeploymentsOutput {
        return get_container_service_deployments.execute(self, allocator, input, options);
    }

    /// Returns the data points of a specific metric of your Amazon Lightsail
    /// container
    /// service.
    ///
    /// Metrics report the utilization of your resources. Monitor and collect metric
    /// data
    /// regularly to maintain the reliability, availability, and performance of your
    /// resources.
    pub fn getContainerServiceMetricData(self: *Self, allocator: std.mem.Allocator, input: get_container_service_metric_data.GetContainerServiceMetricDataInput, options: CallOptions) !get_container_service_metric_data.GetContainerServiceMetricDataOutput {
        return get_container_service_metric_data.execute(self, allocator, input, options);
    }

    /// Returns the list of powers that can be specified for your Amazon Lightsail
    /// container
    /// services.
    ///
    /// The power specifies the amount of memory, the number of vCPUs, and the base
    /// price of the
    /// container service.
    pub fn getContainerServicePowers(self: *Self, allocator: std.mem.Allocator, input: get_container_service_powers.GetContainerServicePowersInput, options: CallOptions) !get_container_service_powers.GetContainerServicePowersOutput {
        return get_container_service_powers.execute(self, allocator, input, options);
    }

    /// Returns information about one or more of your Amazon Lightsail container
    /// services.
    pub fn getContainerServices(self: *Self, allocator: std.mem.Allocator, input: get_container_services.GetContainerServicesInput, options: CallOptions) !get_container_services.GetContainerServicesOutput {
        return get_container_services.execute(self, allocator, input, options);
    }

    /// Retrieves information about the cost estimate for a specified resource. A
    /// cost estimate
    /// will not generate for a resource that has been deleted.
    pub fn getCostEstimate(self: *Self, allocator: std.mem.Allocator, input: get_cost_estimate.GetCostEstimateInput, options: CallOptions) !get_cost_estimate.GetCostEstimateOutput {
        return get_cost_estimate.execute(self, allocator, input, options);
    }

    /// Returns information about a specific block storage disk.
    pub fn getDisk(self: *Self, allocator: std.mem.Allocator, input: get_disk.GetDiskInput, options: CallOptions) !get_disk.GetDiskOutput {
        return get_disk.execute(self, allocator, input, options);
    }

    /// Returns information about a specific block storage disk snapshot.
    pub fn getDiskSnapshot(self: *Self, allocator: std.mem.Allocator, input: get_disk_snapshot.GetDiskSnapshotInput, options: CallOptions) !get_disk_snapshot.GetDiskSnapshotOutput {
        return get_disk_snapshot.execute(self, allocator, input, options);
    }

    /// Returns information about all block storage disk snapshots in your AWS
    /// account and
    /// region.
    pub fn getDiskSnapshots(self: *Self, allocator: std.mem.Allocator, input: get_disk_snapshots.GetDiskSnapshotsInput, options: CallOptions) !get_disk_snapshots.GetDiskSnapshotsOutput {
        return get_disk_snapshots.execute(self, allocator, input, options);
    }

    /// Returns information about all block storage disks in your AWS account and
    /// region.
    pub fn getDisks(self: *Self, allocator: std.mem.Allocator, input: get_disks.GetDisksInput, options: CallOptions) !get_disks.GetDisksOutput {
        return get_disks.execute(self, allocator, input, options);
    }

    /// Returns the bundles that can be applied to your Amazon Lightsail content
    /// delivery network
    /// (CDN) distributions.
    ///
    /// A distribution bundle specifies the monthly network transfer quota and
    /// monthly cost of
    /// your distribution.
    pub fn getDistributionBundles(self: *Self, allocator: std.mem.Allocator, input: get_distribution_bundles.GetDistributionBundlesInput, options: CallOptions) !get_distribution_bundles.GetDistributionBundlesOutput {
        return get_distribution_bundles.execute(self, allocator, input, options);
    }

    /// Returns the timestamp and status of the last cache reset of a specific
    /// Amazon Lightsail
    /// content delivery network (CDN) distribution.
    pub fn getDistributionLatestCacheReset(self: *Self, allocator: std.mem.Allocator, input: get_distribution_latest_cache_reset.GetDistributionLatestCacheResetInput, options: CallOptions) !get_distribution_latest_cache_reset.GetDistributionLatestCacheResetOutput {
        return get_distribution_latest_cache_reset.execute(self, allocator, input, options);
    }

    /// Returns the data points of a specific metric for an Amazon Lightsail content
    /// delivery
    /// network (CDN) distribution.
    ///
    /// Metrics report the utilization of your resources, and the error counts
    /// generated by them.
    /// Monitor and collect metric data regularly to maintain the reliability,
    /// availability, and
    /// performance of your resources.
    pub fn getDistributionMetricData(self: *Self, allocator: std.mem.Allocator, input: get_distribution_metric_data.GetDistributionMetricDataInput, options: CallOptions) !get_distribution_metric_data.GetDistributionMetricDataOutput {
        return get_distribution_metric_data.execute(self, allocator, input, options);
    }

    /// Returns information about one or more of your Amazon Lightsail content
    /// delivery network
    /// (CDN) distributions.
    pub fn getDistributions(self: *Self, allocator: std.mem.Allocator, input: get_distributions.GetDistributionsInput, options: CallOptions) !get_distributions.GetDistributionsOutput {
        return get_distributions.execute(self, allocator, input, options);
    }

    /// Returns information about a specific domain recordset.
    pub fn getDomain(self: *Self, allocator: std.mem.Allocator, input: get_domain.GetDomainInput, options: CallOptions) !get_domain.GetDomainOutput {
        return get_domain.execute(self, allocator, input, options);
    }

    /// Returns a list of all domains in the user's account.
    pub fn getDomains(self: *Self, allocator: std.mem.Allocator, input: get_domains.GetDomainsInput, options: CallOptions) !get_domains.GetDomainsOutput {
        return get_domains.execute(self, allocator, input, options);
    }

    /// Returns all export snapshot records created as a result of the `export
    /// snapshot` operation.
    ///
    /// An export snapshot record can be used to create a new Amazon EC2 instance
    /// and its related
    /// resources with the
    /// [CreateCloudFormationStack](https://docs.aws.amazon.com/lightsail/2016-11-28/api-reference/API_CreateCloudFormationStack.html)
    /// action.
    pub fn getExportSnapshotRecords(self: *Self, allocator: std.mem.Allocator, input: get_export_snapshot_records.GetExportSnapshotRecordsInput, options: CallOptions) !get_export_snapshot_records.GetExportSnapshotRecordsOutput {
        return get_export_snapshot_records.execute(self, allocator, input, options);
    }

    /// Returns information about a specific Amazon Lightsail instance, which is a
    /// virtual private
    /// server.
    pub fn getInstance(self: *Self, allocator: std.mem.Allocator, input: get_instance.GetInstanceInput, options: CallOptions) !get_instance.GetInstanceOutput {
        return get_instance.execute(self, allocator, input, options);
    }

    /// Returns temporary SSH keys you can use to connect to a specific virtual
    /// private server, or
    /// *instance*.
    ///
    /// The `get instance access details` operation supports tag-based access
    /// control
    /// via resource tags applied to the resource identified by `instance name`. For
    /// more
    /// information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn getInstanceAccessDetails(self: *Self, allocator: std.mem.Allocator, input: get_instance_access_details.GetInstanceAccessDetailsInput, options: CallOptions) !get_instance_access_details.GetInstanceAccessDetailsOutput {
        return get_instance_access_details.execute(self, allocator, input, options);
    }

    /// Returns the data points for the specified Amazon Lightsail instance metric,
    /// given an
    /// instance name.
    ///
    /// Metrics report the utilization of your resources, and the error counts
    /// generated by them.
    /// Monitor and collect metric data regularly to maintain the reliability,
    /// availability, and
    /// performance of your resources.
    pub fn getInstanceMetricData(self: *Self, allocator: std.mem.Allocator, input: get_instance_metric_data.GetInstanceMetricDataInput, options: CallOptions) !get_instance_metric_data.GetInstanceMetricDataOutput {
        return get_instance_metric_data.execute(self, allocator, input, options);
    }

    /// Returns the firewall port states for a specific Amazon Lightsail instance,
    /// the IP addresses
    /// allowed to connect to the instance through the ports, and the protocol.
    pub fn getInstancePortStates(self: *Self, allocator: std.mem.Allocator, input: get_instance_port_states.GetInstancePortStatesInput, options: CallOptions) !get_instance_port_states.GetInstancePortStatesOutput {
        return get_instance_port_states.execute(self, allocator, input, options);
    }

    /// Returns information about a specific instance snapshot.
    pub fn getInstanceSnapshot(self: *Self, allocator: std.mem.Allocator, input: get_instance_snapshot.GetInstanceSnapshotInput, options: CallOptions) !get_instance_snapshot.GetInstanceSnapshotOutput {
        return get_instance_snapshot.execute(self, allocator, input, options);
    }

    /// Returns all instance snapshots for the user's account.
    pub fn getInstanceSnapshots(self: *Self, allocator: std.mem.Allocator, input: get_instance_snapshots.GetInstanceSnapshotsInput, options: CallOptions) !get_instance_snapshots.GetInstanceSnapshotsOutput {
        return get_instance_snapshots.execute(self, allocator, input, options);
    }

    /// Returns the state of a specific instance. Works on one instance at a time.
    pub fn getInstanceState(self: *Self, allocator: std.mem.Allocator, input: get_instance_state.GetInstanceStateInput, options: CallOptions) !get_instance_state.GetInstanceStateOutput {
        return get_instance_state.execute(self, allocator, input, options);
    }

    /// Returns information about all Amazon Lightsail virtual private servers, or
    /// *instances*.
    pub fn getInstances(self: *Self, allocator: std.mem.Allocator, input: get_instances.GetInstancesInput, options: CallOptions) !get_instances.GetInstancesOutput {
        return get_instances.execute(self, allocator, input, options);
    }

    /// Returns information about a specific key pair.
    pub fn getKeyPair(self: *Self, allocator: std.mem.Allocator, input: get_key_pair.GetKeyPairInput, options: CallOptions) !get_key_pair.GetKeyPairOutput {
        return get_key_pair.execute(self, allocator, input, options);
    }

    /// Returns information about all key pairs in the user's account.
    pub fn getKeyPairs(self: *Self, allocator: std.mem.Allocator, input: get_key_pairs.GetKeyPairsInput, options: CallOptions) !get_key_pairs.GetKeyPairsOutput {
        return get_key_pairs.execute(self, allocator, input, options);
    }

    /// Returns information about the specified Lightsail load balancer.
    pub fn getLoadBalancer(self: *Self, allocator: std.mem.Allocator, input: get_load_balancer.GetLoadBalancerInput, options: CallOptions) !get_load_balancer.GetLoadBalancerOutput {
        return get_load_balancer.execute(self, allocator, input, options);
    }

    /// Returns information about health metrics for your Lightsail load balancer.
    ///
    /// Metrics report the utilization of your resources, and the error counts
    /// generated by them.
    /// Monitor and collect metric data regularly to maintain the reliability,
    /// availability, and
    /// performance of your resources.
    pub fn getLoadBalancerMetricData(self: *Self, allocator: std.mem.Allocator, input: get_load_balancer_metric_data.GetLoadBalancerMetricDataInput, options: CallOptions) !get_load_balancer_metric_data.GetLoadBalancerMetricDataOutput {
        return get_load_balancer_metric_data.execute(self, allocator, input, options);
    }

    /// Returns information about the TLS certificates that are associated with the
    /// specified
    /// Lightsail load balancer.
    ///
    /// TLS is just an updated, more secure version of Secure Socket Layer (SSL).
    ///
    /// You can have a maximum of 2 certificates associated with a Lightsail load
    /// balancer. One
    /// is active and the other is inactive.
    pub fn getLoadBalancerTlsCertificates(self: *Self, allocator: std.mem.Allocator, input: get_load_balancer_tls_certificates.GetLoadBalancerTlsCertificatesInput, options: CallOptions) !get_load_balancer_tls_certificates.GetLoadBalancerTlsCertificatesOutput {
        return get_load_balancer_tls_certificates.execute(self, allocator, input, options);
    }

    /// Returns a list of TLS security policies that you can apply to Lightsail load
    /// balancers.
    ///
    /// For more information about load balancer TLS security policies, see
    /// [Configuring TLS security policies on your Amazon Lightsail load
    /// balancers](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-configure-load-balancer-tls-security-policy) in the *Amazon Lightsail Developer Guide*.
    pub fn getLoadBalancerTlsPolicies(self: *Self, allocator: std.mem.Allocator, input: get_load_balancer_tls_policies.GetLoadBalancerTlsPoliciesInput, options: CallOptions) !get_load_balancer_tls_policies.GetLoadBalancerTlsPoliciesOutput {
        return get_load_balancer_tls_policies.execute(self, allocator, input, options);
    }

    /// Returns information about all load balancers in an account.
    pub fn getLoadBalancers(self: *Self, allocator: std.mem.Allocator, input: get_load_balancers.GetLoadBalancersInput, options: CallOptions) !get_load_balancers.GetLoadBalancersOutput {
        return get_load_balancers.execute(self, allocator, input, options);
    }

    /// Returns information about a specific operation. Operations include events
    /// such as when you
    /// create an instance, allocate a static IP, attach a static IP, and so on.
    pub fn getOperation(self: *Self, allocator: std.mem.Allocator, input: get_operation.GetOperationInput, options: CallOptions) !get_operation.GetOperationOutput {
        return get_operation.execute(self, allocator, input, options);
    }

    /// Returns information about all operations.
    ///
    /// Results are returned from oldest to newest, up to a maximum of 200. Results
    /// can be paged
    /// by making each subsequent call to `GetOperations` use the maximum (last)
    /// `statusChangedAt` value from the previous request.
    pub fn getOperations(self: *Self, allocator: std.mem.Allocator, input: get_operations.GetOperationsInput, options: CallOptions) !get_operations.GetOperationsOutput {
        return get_operations.execute(self, allocator, input, options);
    }

    /// Gets operations for a specific resource (an instance or a static IP).
    pub fn getOperationsForResource(self: *Self, allocator: std.mem.Allocator, input: get_operations_for_resource.GetOperationsForResourceInput, options: CallOptions) !get_operations_for_resource.GetOperationsForResourceOutput {
        return get_operations_for_resource.execute(self, allocator, input, options);
    }

    /// Returns a list of all valid regions for Amazon Lightsail. Use the `include
    /// availability zones` parameter to also return the Availability Zones in a
    /// region.
    pub fn getRegions(self: *Self, allocator: std.mem.Allocator, input: get_regions.GetRegionsInput, options: CallOptions) !get_regions.GetRegionsOutput {
        return get_regions.execute(self, allocator, input, options);
    }

    /// Returns information about a specific database in Amazon Lightsail.
    pub fn getRelationalDatabase(self: *Self, allocator: std.mem.Allocator, input: get_relational_database.GetRelationalDatabaseInput, options: CallOptions) !get_relational_database.GetRelationalDatabaseOutput {
        return get_relational_database.execute(self, allocator, input, options);
    }

    /// Returns a list of available database blueprints in Amazon Lightsail. A
    /// blueprint describes
    /// the major engine version of a database.
    ///
    /// You can use a blueprint ID to create a new database that runs a specific
    /// database
    /// engine.
    pub fn getRelationalDatabaseBlueprints(self: *Self, allocator: std.mem.Allocator, input: get_relational_database_blueprints.GetRelationalDatabaseBlueprintsInput, options: CallOptions) !get_relational_database_blueprints.GetRelationalDatabaseBlueprintsOutput {
        return get_relational_database_blueprints.execute(self, allocator, input, options);
    }

    /// Returns the list of bundles that are available in Amazon Lightsail. A bundle
    /// describes the
    /// performance specifications for a database.
    ///
    /// You can use a bundle ID to create a new database with explicit performance
    /// specifications.
    pub fn getRelationalDatabaseBundles(self: *Self, allocator: std.mem.Allocator, input: get_relational_database_bundles.GetRelationalDatabaseBundlesInput, options: CallOptions) !get_relational_database_bundles.GetRelationalDatabaseBundlesOutput {
        return get_relational_database_bundles.execute(self, allocator, input, options);
    }

    /// Returns a list of events for a specific database in Amazon Lightsail.
    pub fn getRelationalDatabaseEvents(self: *Self, allocator: std.mem.Allocator, input: get_relational_database_events.GetRelationalDatabaseEventsInput, options: CallOptions) !get_relational_database_events.GetRelationalDatabaseEventsOutput {
        return get_relational_database_events.execute(self, allocator, input, options);
    }

    /// Returns a list of log events for a database in Amazon Lightsail.
    pub fn getRelationalDatabaseLogEvents(self: *Self, allocator: std.mem.Allocator, input: get_relational_database_log_events.GetRelationalDatabaseLogEventsInput, options: CallOptions) !get_relational_database_log_events.GetRelationalDatabaseLogEventsOutput {
        return get_relational_database_log_events.execute(self, allocator, input, options);
    }

    /// Returns a list of available log streams for a specific database in Amazon
    /// Lightsail.
    pub fn getRelationalDatabaseLogStreams(self: *Self, allocator: std.mem.Allocator, input: get_relational_database_log_streams.GetRelationalDatabaseLogStreamsInput, options: CallOptions) !get_relational_database_log_streams.GetRelationalDatabaseLogStreamsOutput {
        return get_relational_database_log_streams.execute(self, allocator, input, options);
    }

    /// Returns the current, previous, or pending versions of the master user
    /// password for a
    /// Lightsail database.
    ///
    /// The `GetRelationalDatabaseMasterUserPassword` operation supports tag-based
    /// access control via resource tags applied to the resource identified by
    /// relationalDatabaseName.
    pub fn getRelationalDatabaseMasterUserPassword(self: *Self, allocator: std.mem.Allocator, input: get_relational_database_master_user_password.GetRelationalDatabaseMasterUserPasswordInput, options: CallOptions) !get_relational_database_master_user_password.GetRelationalDatabaseMasterUserPasswordOutput {
        return get_relational_database_master_user_password.execute(self, allocator, input, options);
    }

    /// Returns the data points of the specified metric for a database in Amazon
    /// Lightsail.
    ///
    /// Metrics report the utilization of your resources, and the error counts
    /// generated by them.
    /// Monitor and collect metric data regularly to maintain the reliability,
    /// availability, and
    /// performance of your resources.
    pub fn getRelationalDatabaseMetricData(self: *Self, allocator: std.mem.Allocator, input: get_relational_database_metric_data.GetRelationalDatabaseMetricDataInput, options: CallOptions) !get_relational_database_metric_data.GetRelationalDatabaseMetricDataOutput {
        return get_relational_database_metric_data.execute(self, allocator, input, options);
    }

    /// Returns all of the runtime parameters offered by the underlying database
    /// software, or
    /// engine, for a specific database in Amazon Lightsail.
    ///
    /// In addition to the parameter names and values, this operation returns other
    /// information
    /// about each parameter. This information includes whether changes require a
    /// reboot, whether the
    /// parameter is modifiable, the allowed values, and the data types.
    pub fn getRelationalDatabaseParameters(self: *Self, allocator: std.mem.Allocator, input: get_relational_database_parameters.GetRelationalDatabaseParametersInput, options: CallOptions) !get_relational_database_parameters.GetRelationalDatabaseParametersOutput {
        return get_relational_database_parameters.execute(self, allocator, input, options);
    }

    /// Returns information about a specific database snapshot in Amazon Lightsail.
    pub fn getRelationalDatabaseSnapshot(self: *Self, allocator: std.mem.Allocator, input: get_relational_database_snapshot.GetRelationalDatabaseSnapshotInput, options: CallOptions) !get_relational_database_snapshot.GetRelationalDatabaseSnapshotOutput {
        return get_relational_database_snapshot.execute(self, allocator, input, options);
    }

    /// Returns information about all of your database snapshots in Amazon
    /// Lightsail.
    pub fn getRelationalDatabaseSnapshots(self: *Self, allocator: std.mem.Allocator, input: get_relational_database_snapshots.GetRelationalDatabaseSnapshotsInput, options: CallOptions) !get_relational_database_snapshots.GetRelationalDatabaseSnapshotsOutput {
        return get_relational_database_snapshots.execute(self, allocator, input, options);
    }

    /// Returns information about all of your databases in Amazon Lightsail.
    pub fn getRelationalDatabases(self: *Self, allocator: std.mem.Allocator, input: get_relational_databases.GetRelationalDatabasesInput, options: CallOptions) !get_relational_databases.GetRelationalDatabasesOutput {
        return get_relational_databases.execute(self, allocator, input, options);
    }

    /// Returns detailed information for five of the most recent
    /// `SetupInstanceHttps`
    /// requests that were ran on the target instance.
    pub fn getSetupHistory(self: *Self, allocator: std.mem.Allocator, input: get_setup_history.GetSetupHistoryInput, options: CallOptions) !get_setup_history.GetSetupHistoryOutput {
        return get_setup_history.execute(self, allocator, input, options);
    }

    /// Returns information about an Amazon Lightsail static IP.
    pub fn getStaticIp(self: *Self, allocator: std.mem.Allocator, input: get_static_ip.GetStaticIpInput, options: CallOptions) !get_static_ip.GetStaticIpOutput {
        return get_static_ip.execute(self, allocator, input, options);
    }

    /// Returns information about all static IPs in the user's account.
    pub fn getStaticIps(self: *Self, allocator: std.mem.Allocator, input: get_static_ips.GetStaticIpsInput, options: CallOptions) !get_static_ips.GetStaticIpsOutput {
        return get_static_ips.execute(self, allocator, input, options);
    }

    /// Imports a public SSH key from a specific key pair.
    pub fn importKeyPair(self: *Self, allocator: std.mem.Allocator, input: import_key_pair.ImportKeyPairInput, options: CallOptions) !import_key_pair.ImportKeyPairOutput {
        return import_key_pair.execute(self, allocator, input, options);
    }

    /// Returns a Boolean value indicating whether your Lightsail VPC is peered.
    pub fn isVpcPeered(self: *Self, allocator: std.mem.Allocator, input: is_vpc_peered.IsVpcPeeredInput, options: CallOptions) !is_vpc_peered.IsVpcPeeredOutput {
        return is_vpc_peered.execute(self, allocator, input, options);
    }

    /// Opens ports for a specific Amazon Lightsail instance, and specifies the IP
    /// addresses
    /// allowed to connect to the instance through the ports, and the protocol.
    ///
    /// The `OpenInstancePublicPorts` action supports tag-based access control via
    /// resource tags applied to the resource identified by `instanceName`. For more
    /// information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn openInstancePublicPorts(self: *Self, allocator: std.mem.Allocator, input: open_instance_public_ports.OpenInstancePublicPortsInput, options: CallOptions) !open_instance_public_ports.OpenInstancePublicPortsOutput {
        return open_instance_public_ports.execute(self, allocator, input, options);
    }

    /// Peers the Lightsail VPC with the user's default VPC.
    pub fn peerVpc(self: *Self, allocator: std.mem.Allocator, input: peer_vpc.PeerVpcInput, options: CallOptions) !peer_vpc.PeerVpcOutput {
        return peer_vpc.execute(self, allocator, input, options);
    }

    /// Creates or updates an alarm, and associates it with the specified metric.
    ///
    /// An alarm is used to monitor a single metric for one of your resources. When
    /// a metric
    /// condition is met, the alarm can notify you by email, SMS text message, and a
    /// banner displayed
    /// on the Amazon Lightsail console. For more information, see [Alarms
    /// in Amazon
    /// Lightsail](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-alarms).
    ///
    /// When this action creates an alarm, the alarm state is immediately set to
    /// `INSUFFICIENT_DATA`. The alarm is then evaluated and its state is set
    /// appropriately. Any actions associated with the new state are then executed.
    ///
    /// When you update an existing alarm, its state is left unchanged, but the
    /// update completely
    /// overwrites the previous configuration of the alarm. The alarm is then
    /// evaluated with the
    /// updated configuration.
    ///
    /// The `put alarm` operation supports tag-based access control via request
    /// tags. For more information, see the [Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn putAlarm(self: *Self, allocator: std.mem.Allocator, input: put_alarm.PutAlarmInput, options: CallOptions) !put_alarm.PutAlarmOutput {
        return put_alarm.execute(self, allocator, input, options);
    }

    /// Opens ports for a specific Amazon Lightsail instance, and specifies the IP
    /// addresses
    /// allowed to connect to the instance through the ports, and the protocol. This
    /// action also
    /// closes all currently open ports that are not included in the request.
    /// Include all of the ports
    /// and the protocols you want to open in your `PutInstancePublicPorts`request.
    /// Or use
    /// the `OpenInstancePublicPorts` action to open ports without closing currently
    /// open
    /// ports.
    ///
    /// The `PutInstancePublicPorts` action supports tag-based access control via
    /// resource tags applied to the resource identified by `instanceName`. For more
    /// information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn putInstancePublicPorts(self: *Self, allocator: std.mem.Allocator, input: put_instance_public_ports.PutInstancePublicPortsInput, options: CallOptions) !put_instance_public_ports.PutInstancePublicPortsOutput {
        return put_instance_public_ports.execute(self, allocator, input, options);
    }

    /// Restarts a specific instance.
    ///
    /// The `reboot instance` operation supports tag-based access control via
    /// resource
    /// tags applied to the resource identified by `instance name`. For more
    /// information,
    /// see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn rebootInstance(self: *Self, allocator: std.mem.Allocator, input: reboot_instance.RebootInstanceInput, options: CallOptions) !reboot_instance.RebootInstanceOutput {
        return reboot_instance.execute(self, allocator, input, options);
    }

    /// Restarts a specific database in Amazon Lightsail.
    ///
    /// The `reboot relational database` operation supports tag-based access control
    /// via resource tags applied to the resource identified by
    /// relationalDatabaseName. For more
    /// information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn rebootRelationalDatabase(self: *Self, allocator: std.mem.Allocator, input: reboot_relational_database.RebootRelationalDatabaseInput, options: CallOptions) !reboot_relational_database.RebootRelationalDatabaseOutput {
        return reboot_relational_database.execute(self, allocator, input, options);
    }

    /// Registers a container image to your Amazon Lightsail container service.
    ///
    /// This action is not required if you install and use the Lightsail Control
    /// (lightsailctl) plugin to push container images to your Lightsail container
    /// service. For
    /// more information, see [Pushing and managing container images on your Amazon
    /// Lightsail container
    /// services](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-pushing-container-images)
    /// in the *Amazon Lightsail Developer Guide*.
    pub fn registerContainerImage(self: *Self, allocator: std.mem.Allocator, input: register_container_image.RegisterContainerImageInput, options: CallOptions) !register_container_image.RegisterContainerImageOutput {
        return register_container_image.execute(self, allocator, input, options);
    }

    /// Deletes a specific static IP from your account.
    pub fn releaseStaticIp(self: *Self, allocator: std.mem.Allocator, input: release_static_ip.ReleaseStaticIpInput, options: CallOptions) !release_static_ip.ReleaseStaticIpOutput {
        return release_static_ip.execute(self, allocator, input, options);
    }

    /// Deletes currently cached content from your Amazon Lightsail content delivery
    /// network (CDN)
    /// distribution.
    ///
    /// After resetting the cache, the next time a content request is made, your
    /// distribution
    /// pulls, serves, and caches it from the origin.
    pub fn resetDistributionCache(self: *Self, allocator: std.mem.Allocator, input: reset_distribution_cache.ResetDistributionCacheInput, options: CallOptions) !reset_distribution_cache.ResetDistributionCacheOutput {
        return reset_distribution_cache.execute(self, allocator, input, options);
    }

    /// Sends a verification request to an email contact method to ensure it's owned
    /// by the
    /// requester. SMS contact methods don't need to be verified.
    ///
    /// A contact method is used to send you notifications about your Amazon
    /// Lightsail resources.
    /// You can add one email address and one mobile phone number contact method in
    /// each Amazon Web Services Region. However, SMS text messaging is not
    /// supported in some Amazon Web Services
    /// Regions, and SMS text messages cannot be sent to some countries/regions. For
    /// more information,
    /// see [Notifications in Amazon
    /// Lightsail](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-notifications).
    ///
    /// A verification request is sent to the contact method when you initially
    /// create it. Use
    /// this action to send another verification request if a previous verification
    /// request was
    /// deleted, or has expired.
    ///
    /// Notifications are not sent to an email contact method until after it is
    /// verified, and
    /// confirmed as valid.
    pub fn sendContactMethodVerification(self: *Self, allocator: std.mem.Allocator, input: send_contact_method_verification.SendContactMethodVerificationInput, options: CallOptions) !send_contact_method_verification.SendContactMethodVerificationOutput {
        return send_contact_method_verification.execute(self, allocator, input, options);
    }

    /// Sets the IP address type for an Amazon Lightsail resource.
    ///
    /// Use this action to enable dual-stack for a resource, which enables IPv4 and
    /// IPv6 for the
    /// specified resource. Alternately, you can use this action to disable
    /// dual-stack, and enable
    /// IPv4 only.
    pub fn setIpAddressType(self: *Self, allocator: std.mem.Allocator, input: set_ip_address_type.SetIpAddressTypeInput, options: CallOptions) !set_ip_address_type.SetIpAddressTypeOutput {
        return set_ip_address_type.execute(self, allocator, input, options);
    }

    /// Sets the Amazon Lightsail resources that can access the specified Lightsail
    /// bucket.
    ///
    /// Lightsail buckets currently support setting access for Lightsail instances
    /// in the same
    /// Amazon Web Services Region.
    pub fn setResourceAccessForBucket(self: *Self, allocator: std.mem.Allocator, input: set_resource_access_for_bucket.SetResourceAccessForBucketInput, options: CallOptions) !set_resource_access_for_bucket.SetResourceAccessForBucketOutput {
        return set_resource_access_for_bucket.execute(self, allocator, input, options);
    }

    /// Creates an SSL/TLS certificate that secures traffic for your website. After
    /// the
    /// certificate is created, it is installed on the specified Lightsail instance.
    ///
    /// If you provide more than one domain name in the request, at least one name
    /// must be less
    /// than or equal to 63 characters in length.
    pub fn setupInstanceHttps(self: *Self, allocator: std.mem.Allocator, input: setup_instance_https.SetupInstanceHttpsInput, options: CallOptions) !setup_instance_https.SetupInstanceHttpsOutput {
        return setup_instance_https.execute(self, allocator, input, options);
    }

    /// Initiates a graphical user interface (GUI) session that’s used to access a
    /// virtual
    /// computer’s operating system and application. The session will be active for
    /// 1 hour. Use this
    /// action to resume the session after it expires.
    pub fn startGuiSession(self: *Self, allocator: std.mem.Allocator, input: start_gui_session.StartGUISessionInput, options: CallOptions) !start_gui_session.StartGUISessionOutput {
        return start_gui_session.execute(self, allocator, input, options);
    }

    /// Starts a specific Amazon Lightsail instance from a stopped state. To restart
    /// an instance,
    /// use the `reboot instance` operation.
    ///
    /// When you start a stopped instance, Lightsail assigns a new public IP address
    /// to the
    /// instance. To use the same IP address after stopping and starting an
    /// instance, create a
    /// static IP address and attach it to the instance. For more information, see
    /// the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/lightsail-create-static-ip).
    ///
    /// The `start instance` operation supports tag-based access control via
    /// resource
    /// tags applied to the resource identified by `instance name`. For more
    /// information,
    /// see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn startInstance(self: *Self, allocator: std.mem.Allocator, input: start_instance.StartInstanceInput, options: CallOptions) !start_instance.StartInstanceOutput {
        return start_instance.execute(self, allocator, input, options);
    }

    /// Starts a specific database from a stopped state in Amazon Lightsail. To
    /// restart a database,
    /// use the `reboot relational database` operation.
    ///
    /// The `start relational database` operation supports tag-based access control
    /// via
    /// resource tags applied to the resource identified by relationalDatabaseName.
    /// For more
    /// information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn startRelationalDatabase(self: *Self, allocator: std.mem.Allocator, input: start_relational_database.StartRelationalDatabaseInput, options: CallOptions) !start_relational_database.StartRelationalDatabaseOutput {
        return start_relational_database.execute(self, allocator, input, options);
    }

    /// Terminates a web-based Amazon DCV session that’s used to access a virtual
    /// computer’s
    /// operating system or application. The session will close and any unsaved data
    /// will be
    /// lost.
    pub fn stopGuiSession(self: *Self, allocator: std.mem.Allocator, input: stop_gui_session.StopGUISessionInput, options: CallOptions) !stop_gui_session.StopGUISessionOutput {
        return stop_gui_session.execute(self, allocator, input, options);
    }

    /// Stops a specific Amazon Lightsail instance that is currently running.
    ///
    /// When you start a stopped instance, Lightsail assigns a new public IP address
    /// to the
    /// instance. To use the same IP address after stopping and starting an
    /// instance, create a
    /// static IP address and attach it to the instance. For more information, see
    /// the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/lightsail-create-static-ip).
    ///
    /// The `stop instance` operation supports tag-based access control via resource
    /// tags applied to the resource identified by `instance name`. For more
    /// information,
    /// see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn stopInstance(self: *Self, allocator: std.mem.Allocator, input: stop_instance.StopInstanceInput, options: CallOptions) !stop_instance.StopInstanceOutput {
        return stop_instance.execute(self, allocator, input, options);
    }

    /// Stops a specific database that is currently running in Amazon Lightsail.
    ///
    /// If you don't manually start your database instance after it has been stopped
    /// for seven
    /// consecutive days, Amazon Lightsail automatically starts it for you. This
    /// action helps ensure
    /// that your database instance doesn't fall behind on any required maintenance
    /// updates.
    ///
    /// The `stop relational database` operation supports tag-based access control
    /// via
    /// resource tags applied to the resource identified by relationalDatabaseName.
    /// For more
    /// information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn stopRelationalDatabase(self: *Self, allocator: std.mem.Allocator, input: stop_relational_database.StopRelationalDatabaseInput, options: CallOptions) !stop_relational_database.StopRelationalDatabaseOutput {
        return stop_relational_database.execute(self, allocator, input, options);
    }

    /// Adds one or more tags to the specified Amazon Lightsail resource. Each
    /// resource can have a
    /// maximum of 50 tags. Each tag consists of a key and an optional value. Tag
    /// keys must be unique
    /// per resource. For more information about tags, see the [Amazon Lightsail
    /// Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-tags).
    ///
    /// The `tag resource` operation supports tag-based access control via request
    /// tags
    /// and resource tags applied to the resource identified by `resource name`. For
    /// more
    /// information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Tests an alarm by displaying a banner on the Amazon Lightsail console. If a
    /// notification
    /// trigger is configured for the specified alarm, the test also sends a
    /// notification to the
    /// notification protocol (`Email` and/or `SMS`) configured for the
    /// alarm.
    ///
    /// An alarm is used to monitor a single metric for one of your resources. When
    /// a metric
    /// condition is met, the alarm can notify you by email, SMS text message, and a
    /// banner displayed
    /// on the Amazon Lightsail console. For more information, see [Alarms
    /// in Amazon
    /// Lightsail](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-alarms).
    pub fn testAlarm(self: *Self, allocator: std.mem.Allocator, input: test_alarm.TestAlarmInput, options: CallOptions) !test_alarm.TestAlarmOutput {
        return test_alarm.execute(self, allocator, input, options);
    }

    /// Unpeers the Lightsail VPC from the user's default VPC.
    pub fn unpeerVpc(self: *Self, allocator: std.mem.Allocator, input: unpeer_vpc.UnpeerVpcInput, options: CallOptions) !unpeer_vpc.UnpeerVpcOutput {
        return unpeer_vpc.execute(self, allocator, input, options);
    }

    /// Deletes the specified set of tag keys and their values from the specified
    /// Amazon Lightsail
    /// resource.
    ///
    /// The `untag resource` operation supports tag-based access control via request
    /// tags and resource tags applied to the resource identified by `resource
    /// name`. For
    /// more information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an existing Amazon Lightsail bucket.
    ///
    /// Use this action to update the configuration of an existing bucket, such as
    /// versioning,
    /// public accessibility, and the Amazon Web Services accounts that can access
    /// the bucket.
    pub fn updateBucket(self: *Self, allocator: std.mem.Allocator, input: update_bucket.UpdateBucketInput, options: CallOptions) !update_bucket.UpdateBucketOutput {
        return update_bucket.execute(self, allocator, input, options);
    }

    /// Updates the bundle, or storage plan, of an existing Amazon Lightsail bucket.
    ///
    /// A bucket bundle specifies the monthly cost, storage space, and data transfer
    /// quota for a
    /// bucket. You can update a bucket's bundle only one time within a monthly
    /// Amazon Web Services
    /// billing cycle. To determine if you can update a bucket's bundle, use the
    /// [GetBuckets](https://docs.aws.amazon.com/lightsail/2016-11-28/api-reference/API_GetBuckets.html) action. The
    /// `ableToUpdateBundle` parameter in the response will indicate whether you can
    /// currently update a bucket's bundle.
    ///
    /// Update a bucket's bundle if it's consistently going over its storage space
    /// or data
    /// transfer quota, or if a bucket's usage is consistently in the lower range of
    /// its storage space
    /// or data transfer quota. Due to the unpredictable usage fluctuations that a
    /// bucket might
    /// experience, we strongly recommend that you update a bucket's bundle only as
    /// a long-term
    /// strategy, instead of as a short-term, monthly cost-cutting measure. Choose a
    /// bucket bundle
    /// that will provide the bucket with ample storage space and data transfer for
    /// a long time to
    /// come.
    pub fn updateBucketBundle(self: *Self, allocator: std.mem.Allocator, input: update_bucket_bundle.UpdateBucketBundleInput, options: CallOptions) !update_bucket_bundle.UpdateBucketBundleOutput {
        return update_bucket_bundle.execute(self, allocator, input, options);
    }

    /// Updates the configuration of your Amazon Lightsail container service, such
    /// as its power,
    /// scale, and public domain names.
    pub fn updateContainerService(self: *Self, allocator: std.mem.Allocator, input: update_container_service.UpdateContainerServiceInput, options: CallOptions) !update_container_service.UpdateContainerServiceOutput {
        return update_container_service.execute(self, allocator, input, options);
    }

    /// Updates an existing Amazon Lightsail content delivery network (CDN)
    /// distribution.
    ///
    /// Use this action to update the configuration of your existing distribution.
    pub fn updateDistribution(self: *Self, allocator: std.mem.Allocator, input: update_distribution.UpdateDistributionInput, options: CallOptions) !update_distribution.UpdateDistributionOutput {
        return update_distribution.execute(self, allocator, input, options);
    }

    /// Updates the bundle of your Amazon Lightsail content delivery network (CDN)
    /// distribution.
    ///
    /// A distribution bundle specifies the monthly network transfer quota and
    /// monthly cost of
    /// your distribution.
    ///
    /// Update your distribution's bundle if your distribution is going over its
    /// monthly network
    /// transfer quota and is incurring an overage fee.
    ///
    /// You can update your distribution's bundle only one time within your monthly
    /// Amazon Web Services billing cycle. To determine if you can update your
    /// distribution's bundle, use the
    /// `GetDistributions` action. The `ableToUpdateBundle` parameter in the
    /// result will indicate whether you can currently update your distribution's
    /// bundle.
    pub fn updateDistributionBundle(self: *Self, allocator: std.mem.Allocator, input: update_distribution_bundle.UpdateDistributionBundleInput, options: CallOptions) !update_distribution_bundle.UpdateDistributionBundleOutput {
        return update_distribution_bundle.execute(self, allocator, input, options);
    }

    /// Updates a domain recordset after it is created.
    ///
    /// The `update domain entry` operation supports tag-based access control via
    /// resource tags applied to the resource identified by `domain name`. For more
    /// information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn updateDomainEntry(self: *Self, allocator: std.mem.Allocator, input: update_domain_entry.UpdateDomainEntryInput, options: CallOptions) !update_domain_entry.UpdateDomainEntryOutput {
        return update_domain_entry.execute(self, allocator, input, options);
    }

    /// Modifies the Amazon Lightsail instance metadata parameters on a running or
    /// stopped
    /// instance. When you modify the parameters on a running instance, the
    /// `GetInstance`
    /// or `GetInstances` API operation initially responds with a state of
    /// `pending`. After the parameter modifications are successfully applied, the
    /// state
    /// changes to `applied` in subsequent `GetInstance` or
    /// `GetInstances` API calls. For more information, see [Use IMDSv2 with an
    /// Amazon Lightsail
    /// instance](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-configuring-instance-metadata-service) in the *Amazon Lightsail Developer Guide*.
    pub fn updateInstanceMetadataOptions(self: *Self, allocator: std.mem.Allocator, input: update_instance_metadata_options.UpdateInstanceMetadataOptionsInput, options: CallOptions) !update_instance_metadata_options.UpdateInstanceMetadataOptionsOutput {
        return update_instance_metadata_options.execute(self, allocator, input, options);
    }

    /// Updates the specified attribute for a load balancer. You can only update one
    /// attribute at
    /// a time.
    ///
    /// The `update load balancer attribute` operation supports tag-based access
    /// control via resource tags applied to the resource identified by `load
    /// balancer
    /// name`. For more information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn updateLoadBalancerAttribute(self: *Self, allocator: std.mem.Allocator, input: update_load_balancer_attribute.UpdateLoadBalancerAttributeInput, options: CallOptions) !update_load_balancer_attribute.UpdateLoadBalancerAttributeOutput {
        return update_load_balancer_attribute.execute(self, allocator, input, options);
    }

    /// Allows the update of one or more attributes of a database in Amazon
    /// Lightsail.
    ///
    /// Updates are applied immediately, or in cases where the updates could result
    /// in an outage,
    /// are applied during the database's predefined maintenance window.
    ///
    /// The `update relational database` operation supports tag-based access control
    /// via resource tags applied to the resource identified by
    /// relationalDatabaseName. For more
    /// information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn updateRelationalDatabase(self: *Self, allocator: std.mem.Allocator, input: update_relational_database.UpdateRelationalDatabaseInput, options: CallOptions) !update_relational_database.UpdateRelationalDatabaseOutput {
        return update_relational_database.execute(self, allocator, input, options);
    }

    /// Allows the update of one or more parameters of a database in Amazon
    /// Lightsail.
    ///
    /// Parameter updates don't cause outages; therefore, their application is not
    /// subject to the
    /// preferred maintenance window. However, there are two ways in which parameter
    /// updates are
    /// applied: `dynamic` or `pending-reboot`. Parameters marked with a
    /// `dynamic` apply type are applied immediately. Parameters marked with a
    /// `pending-reboot` apply type are applied only after the database is rebooted
    /// using
    /// the `reboot relational database` operation.
    ///
    /// The `update relational database parameters` operation supports tag-based
    /// access
    /// control via resource tags applied to the resource identified by
    /// relationalDatabaseName. For
    /// more information, see the [Amazon Lightsail Developer
    /// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-controlling-access-using-tags).
    pub fn updateRelationalDatabaseParameters(self: *Self, allocator: std.mem.Allocator, input: update_relational_database_parameters.UpdateRelationalDatabaseParametersInput, options: CallOptions) !update_relational_database_parameters.UpdateRelationalDatabaseParametersOutput {
        return update_relational_database_parameters.execute(self, allocator, input, options);
    }
};
