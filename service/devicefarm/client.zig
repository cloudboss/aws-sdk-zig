const aws = @import("aws");
const std = @import("std");

const create_device_pool = @import("create_device_pool.zig");
const create_instance_profile = @import("create_instance_profile.zig");
const create_network_profile = @import("create_network_profile.zig");
const create_project = @import("create_project.zig");
const create_remote_access_session = @import("create_remote_access_session.zig");
const create_test_grid_project = @import("create_test_grid_project.zig");
const create_test_grid_url = @import("create_test_grid_url.zig");
const create_upload = @import("create_upload.zig");
const create_vpce_configuration = @import("create_vpce_configuration.zig");
const delete_device_pool = @import("delete_device_pool.zig");
const delete_instance_profile = @import("delete_instance_profile.zig");
const delete_network_profile = @import("delete_network_profile.zig");
const delete_project = @import("delete_project.zig");
const delete_remote_access_session = @import("delete_remote_access_session.zig");
const delete_run = @import("delete_run.zig");
const delete_test_grid_project = @import("delete_test_grid_project.zig");
const delete_upload = @import("delete_upload.zig");
const delete_vpce_configuration = @import("delete_vpce_configuration.zig");
const get_account_settings = @import("get_account_settings.zig");
const get_device = @import("get_device.zig");
const get_device_instance = @import("get_device_instance.zig");
const get_device_pool = @import("get_device_pool.zig");
const get_device_pool_compatibility = @import("get_device_pool_compatibility.zig");
const get_instance_profile = @import("get_instance_profile.zig");
const get_job = @import("get_job.zig");
const get_network_profile = @import("get_network_profile.zig");
const get_offering_status = @import("get_offering_status.zig");
const get_project = @import("get_project.zig");
const get_remote_access_session = @import("get_remote_access_session.zig");
const get_run = @import("get_run.zig");
const get_suite = @import("get_suite.zig");
const get_test = @import("get_test.zig");
const get_test_grid_project = @import("get_test_grid_project.zig");
const get_test_grid_session = @import("get_test_grid_session.zig");
const get_upload = @import("get_upload.zig");
const get_vpce_configuration = @import("get_vpce_configuration.zig");
const install_to_remote_access_session = @import("install_to_remote_access_session.zig");
const list_artifacts = @import("list_artifacts.zig");
const list_device_instances = @import("list_device_instances.zig");
const list_device_pools = @import("list_device_pools.zig");
const list_devices = @import("list_devices.zig");
const list_instance_profiles = @import("list_instance_profiles.zig");
const list_jobs = @import("list_jobs.zig");
const list_network_profiles = @import("list_network_profiles.zig");
const list_offering_promotions = @import("list_offering_promotions.zig");
const list_offering_transactions = @import("list_offering_transactions.zig");
const list_offerings = @import("list_offerings.zig");
const list_projects = @import("list_projects.zig");
const list_remote_access_sessions = @import("list_remote_access_sessions.zig");
const list_runs = @import("list_runs.zig");
const list_samples = @import("list_samples.zig");
const list_suites = @import("list_suites.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_test_grid_projects = @import("list_test_grid_projects.zig");
const list_test_grid_session_actions = @import("list_test_grid_session_actions.zig");
const list_test_grid_session_artifacts = @import("list_test_grid_session_artifacts.zig");
const list_test_grid_sessions = @import("list_test_grid_sessions.zig");
const list_tests = @import("list_tests.zig");
const list_unique_problems = @import("list_unique_problems.zig");
const list_uploads = @import("list_uploads.zig");
const list_vpce_configurations = @import("list_vpce_configurations.zig");
const purchase_offering = @import("purchase_offering.zig");
const renew_offering = @import("renew_offering.zig");
const schedule_run = @import("schedule_run.zig");
const stop_job = @import("stop_job.zig");
const stop_remote_access_session = @import("stop_remote_access_session.zig");
const stop_run = @import("stop_run.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_device_instance = @import("update_device_instance.zig");
const update_device_pool = @import("update_device_pool.zig");
const update_instance_profile = @import("update_instance_profile.zig");
const update_network_profile = @import("update_network_profile.zig");
const update_project = @import("update_project.zig");
const update_test_grid_project = @import("update_test_grid_project.zig");
const update_upload = @import("update_upload.zig");
const update_vpce_configuration = @import("update_vpce_configuration.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Device Farm";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Creates a device pool.
    pub fn createDevicePool(self: *Self, allocator: std.mem.Allocator, input: create_device_pool.CreateDevicePoolInput, options: create_device_pool.Options) !create_device_pool.CreateDevicePoolOutput {
        return create_device_pool.execute(self, allocator, input, options);
    }

    /// Creates a profile that can be applied to one or more private fleet device
    /// instances.
    pub fn createInstanceProfile(self: *Self, allocator: std.mem.Allocator, input: create_instance_profile.CreateInstanceProfileInput, options: create_instance_profile.Options) !create_instance_profile.CreateInstanceProfileOutput {
        return create_instance_profile.execute(self, allocator, input, options);
    }

    /// Creates a network profile.
    pub fn createNetworkProfile(self: *Self, allocator: std.mem.Allocator, input: create_network_profile.CreateNetworkProfileInput, options: create_network_profile.Options) !create_network_profile.CreateNetworkProfileOutput {
        return create_network_profile.execute(self, allocator, input, options);
    }

    /// Creates a project.
    pub fn createProject(self: *Self, allocator: std.mem.Allocator, input: create_project.CreateProjectInput, options: create_project.Options) !create_project.CreateProjectOutput {
        return create_project.execute(self, allocator, input, options);
    }

    /// Specifies and starts a remote access session.
    pub fn createRemoteAccessSession(self: *Self, allocator: std.mem.Allocator, input: create_remote_access_session.CreateRemoteAccessSessionInput, options: create_remote_access_session.Options) !create_remote_access_session.CreateRemoteAccessSessionOutput {
        return create_remote_access_session.execute(self, allocator, input, options);
    }

    /// Creates a Selenium testing project. Projects are used to track
    /// TestGridSession
    /// instances.
    pub fn createTestGridProject(self: *Self, allocator: std.mem.Allocator, input: create_test_grid_project.CreateTestGridProjectInput, options: create_test_grid_project.Options) !create_test_grid_project.CreateTestGridProjectOutput {
        return create_test_grid_project.execute(self, allocator, input, options);
    }

    /// Creates a signed, short-term URL that can be passed to a Selenium
    /// `RemoteWebDriver`
    /// constructor.
    pub fn createTestGridUrl(self: *Self, allocator: std.mem.Allocator, input: create_test_grid_url.CreateTestGridUrlInput, options: create_test_grid_url.Options) !create_test_grid_url.CreateTestGridUrlOutput {
        return create_test_grid_url.execute(self, allocator, input, options);
    }

    /// Uploads an app or test scripts.
    pub fn createUpload(self: *Self, allocator: std.mem.Allocator, input: create_upload.CreateUploadInput, options: create_upload.Options) !create_upload.CreateUploadOutput {
        return create_upload.execute(self, allocator, input, options);
    }

    /// Creates a configuration record in Device Farm for your Amazon Virtual
    /// Private Cloud
    /// (VPC) endpoint.
    pub fn createVpceConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_vpce_configuration.CreateVPCEConfigurationInput, options: create_vpce_configuration.Options) !create_vpce_configuration.CreateVPCEConfigurationOutput {
        return create_vpce_configuration.execute(self, allocator, input, options);
    }

    /// Deletes a device pool given the pool ARN. Does not allow deletion of curated
    /// pools
    /// owned by the system.
    pub fn deleteDevicePool(self: *Self, allocator: std.mem.Allocator, input: delete_device_pool.DeleteDevicePoolInput, options: delete_device_pool.Options) !delete_device_pool.DeleteDevicePoolOutput {
        return delete_device_pool.execute(self, allocator, input, options);
    }

    /// Deletes a profile that can be applied to one or more private device
    /// instances.
    pub fn deleteInstanceProfile(self: *Self, allocator: std.mem.Allocator, input: delete_instance_profile.DeleteInstanceProfileInput, options: delete_instance_profile.Options) !delete_instance_profile.DeleteInstanceProfileOutput {
        return delete_instance_profile.execute(self, allocator, input, options);
    }

    /// Deletes a network profile.
    pub fn deleteNetworkProfile(self: *Self, allocator: std.mem.Allocator, input: delete_network_profile.DeleteNetworkProfileInput, options: delete_network_profile.Options) !delete_network_profile.DeleteNetworkProfileOutput {
        return delete_network_profile.execute(self, allocator, input, options);
    }

    /// Deletes an AWS Device Farm project, given the project ARN. You cannot delete
    /// a project if it has an active run or session.
    ///
    /// You cannot undo this operation.
    pub fn deleteProject(self: *Self, allocator: std.mem.Allocator, input: delete_project.DeleteProjectInput, options: delete_project.Options) !delete_project.DeleteProjectOutput {
        return delete_project.execute(self, allocator, input, options);
    }

    /// Deletes a completed remote access session and its results. You cannot delete
    /// a remote access session if it is still active.
    ///
    /// You cannot undo this operation.
    pub fn deleteRemoteAccessSession(self: *Self, allocator: std.mem.Allocator, input: delete_remote_access_session.DeleteRemoteAccessSessionInput, options: delete_remote_access_session.Options) !delete_remote_access_session.DeleteRemoteAccessSessionOutput {
        return delete_remote_access_session.execute(self, allocator, input, options);
    }

    /// Deletes the run, given the run ARN. You cannot delete a run if it is still
    /// active.
    ///
    /// You cannot undo this operation.
    pub fn deleteRun(self: *Self, allocator: std.mem.Allocator, input: delete_run.DeleteRunInput, options: delete_run.Options) !delete_run.DeleteRunOutput {
        return delete_run.execute(self, allocator, input, options);
    }

    /// Deletes a Selenium testing project and all content generated under it. You
    /// cannot delete a project if it has active sessions.
    ///
    /// You cannot undo this operation.
    pub fn deleteTestGridProject(self: *Self, allocator: std.mem.Allocator, input: delete_test_grid_project.DeleteTestGridProjectInput, options: delete_test_grid_project.Options) !delete_test_grid_project.DeleteTestGridProjectOutput {
        return delete_test_grid_project.execute(self, allocator, input, options);
    }

    /// Deletes an upload given the upload ARN.
    pub fn deleteUpload(self: *Self, allocator: std.mem.Allocator, input: delete_upload.DeleteUploadInput, options: delete_upload.Options) !delete_upload.DeleteUploadOutput {
        return delete_upload.execute(self, allocator, input, options);
    }

    /// Deletes a configuration for your Amazon Virtual Private Cloud (VPC)
    /// endpoint.
    pub fn deleteVpceConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_vpce_configuration.DeleteVPCEConfigurationInput, options: delete_vpce_configuration.Options) !delete_vpce_configuration.DeleteVPCEConfigurationOutput {
        return delete_vpce_configuration.execute(self, allocator, input, options);
    }

    /// Returns the number of unmetered iOS or unmetered Android devices that have
    /// been purchased by the
    /// account.
    pub fn getAccountSettings(self: *Self, allocator: std.mem.Allocator, input: get_account_settings.GetAccountSettingsInput, options: get_account_settings.Options) !get_account_settings.GetAccountSettingsOutput {
        return get_account_settings.execute(self, allocator, input, options);
    }

    /// Gets information about a unique device type.
    pub fn getDevice(self: *Self, allocator: std.mem.Allocator, input: get_device.GetDeviceInput, options: get_device.Options) !get_device.GetDeviceOutput {
        return get_device.execute(self, allocator, input, options);
    }

    /// Returns information about a device instance that belongs to a private device
    /// fleet.
    pub fn getDeviceInstance(self: *Self, allocator: std.mem.Allocator, input: get_device_instance.GetDeviceInstanceInput, options: get_device_instance.Options) !get_device_instance.GetDeviceInstanceOutput {
        return get_device_instance.execute(self, allocator, input, options);
    }

    /// Gets information about a device pool.
    pub fn getDevicePool(self: *Self, allocator: std.mem.Allocator, input: get_device_pool.GetDevicePoolInput, options: get_device_pool.Options) !get_device_pool.GetDevicePoolOutput {
        return get_device_pool.execute(self, allocator, input, options);
    }

    /// Gets information about compatibility with a device pool.
    pub fn getDevicePoolCompatibility(self: *Self, allocator: std.mem.Allocator, input: get_device_pool_compatibility.GetDevicePoolCompatibilityInput, options: get_device_pool_compatibility.Options) !get_device_pool_compatibility.GetDevicePoolCompatibilityOutput {
        return get_device_pool_compatibility.execute(self, allocator, input, options);
    }

    /// Returns information about the specified instance profile.
    pub fn getInstanceProfile(self: *Self, allocator: std.mem.Allocator, input: get_instance_profile.GetInstanceProfileInput, options: get_instance_profile.Options) !get_instance_profile.GetInstanceProfileOutput {
        return get_instance_profile.execute(self, allocator, input, options);
    }

    /// Gets information about a job.
    pub fn getJob(self: *Self, allocator: std.mem.Allocator, input: get_job.GetJobInput, options: get_job.Options) !get_job.GetJobOutput {
        return get_job.execute(self, allocator, input, options);
    }

    /// Returns information about a network profile.
    pub fn getNetworkProfile(self: *Self, allocator: std.mem.Allocator, input: get_network_profile.GetNetworkProfileInput, options: get_network_profile.Options) !get_network_profile.GetNetworkProfileOutput {
        return get_network_profile.execute(self, allocator, input, options);
    }

    /// Gets the current status and future status of all offerings purchased by an
    /// AWS account. The response
    /// indicates how many offerings are currently available and the offerings that
    /// will be available in the next
    /// period. The API returns a `NotEligible` error if the user is not permitted
    /// to invoke the
    /// operation. If you must be able to invoke this operation, contact
    /// [aws-devicefarm-support@amazon.com](mailto:aws-devicefarm-support@amazon.com).
    pub fn getOfferingStatus(self: *Self, allocator: std.mem.Allocator, input: get_offering_status.GetOfferingStatusInput, options: get_offering_status.Options) !get_offering_status.GetOfferingStatusOutput {
        return get_offering_status.execute(self, allocator, input, options);
    }

    /// Gets information about a project.
    pub fn getProject(self: *Self, allocator: std.mem.Allocator, input: get_project.GetProjectInput, options: get_project.Options) !get_project.GetProjectOutput {
        return get_project.execute(self, allocator, input, options);
    }

    /// Returns a link to a currently running remote access session.
    pub fn getRemoteAccessSession(self: *Self, allocator: std.mem.Allocator, input: get_remote_access_session.GetRemoteAccessSessionInput, options: get_remote_access_session.Options) !get_remote_access_session.GetRemoteAccessSessionOutput {
        return get_remote_access_session.execute(self, allocator, input, options);
    }

    /// Gets information about a run.
    pub fn getRun(self: *Self, allocator: std.mem.Allocator, input: get_run.GetRunInput, options: get_run.Options) !get_run.GetRunOutput {
        return get_run.execute(self, allocator, input, options);
    }

    /// Gets information about a suite.
    pub fn getSuite(self: *Self, allocator: std.mem.Allocator, input: get_suite.GetSuiteInput, options: get_suite.Options) !get_suite.GetSuiteOutput {
        return get_suite.execute(self, allocator, input, options);
    }

    /// Gets information about a test.
    pub fn getTest(self: *Self, allocator: std.mem.Allocator, input: get_test.GetTestInput, options: get_test.Options) !get_test.GetTestOutput {
        return get_test.execute(self, allocator, input, options);
    }

    /// Retrieves information about a Selenium testing project.
    pub fn getTestGridProject(self: *Self, allocator: std.mem.Allocator, input: get_test_grid_project.GetTestGridProjectInput, options: get_test_grid_project.Options) !get_test_grid_project.GetTestGridProjectOutput {
        return get_test_grid_project.execute(self, allocator, input, options);
    }

    /// A session is an instance of a browser created through a `RemoteWebDriver`
    /// with the URL from CreateTestGridUrlResult$url. You can use the following to
    /// look up sessions:
    ///
    /// * The session ARN (GetTestGridSessionRequest$sessionArn).
    ///
    /// * The project ARN and a session ID (GetTestGridSessionRequest$projectArn and
    ///   GetTestGridSessionRequest$sessionId).
    pub fn getTestGridSession(self: *Self, allocator: std.mem.Allocator, input: get_test_grid_session.GetTestGridSessionInput, options: get_test_grid_session.Options) !get_test_grid_session.GetTestGridSessionOutput {
        return get_test_grid_session.execute(self, allocator, input, options);
    }

    /// Gets information about an upload.
    pub fn getUpload(self: *Self, allocator: std.mem.Allocator, input: get_upload.GetUploadInput, options: get_upload.Options) !get_upload.GetUploadOutput {
        return get_upload.execute(self, allocator, input, options);
    }

    /// Returns information about the configuration settings for your Amazon Virtual
    /// Private
    /// Cloud (VPC) endpoint.
    pub fn getVpceConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_vpce_configuration.GetVPCEConfigurationInput, options: get_vpce_configuration.Options) !get_vpce_configuration.GetVPCEConfigurationOutput {
        return get_vpce_configuration.execute(self, allocator, input, options);
    }

    /// Installs an application to the device in a remote access session. For
    /// Android
    /// applications, the file must be in .apk format. For iOS applications, the
    /// file must be in
    /// .ipa format.
    pub fn installToRemoteAccessSession(self: *Self, allocator: std.mem.Allocator, input: install_to_remote_access_session.InstallToRemoteAccessSessionInput, options: install_to_remote_access_session.Options) !install_to_remote_access_session.InstallToRemoteAccessSessionOutput {
        return install_to_remote_access_session.execute(self, allocator, input, options);
    }

    /// Gets information about artifacts.
    pub fn listArtifacts(self: *Self, allocator: std.mem.Allocator, input: list_artifacts.ListArtifactsInput, options: list_artifacts.Options) !list_artifacts.ListArtifactsOutput {
        return list_artifacts.execute(self, allocator, input, options);
    }

    /// Returns information about the private device instances associated with one
    /// or more AWS
    /// accounts.
    pub fn listDeviceInstances(self: *Self, allocator: std.mem.Allocator, input: list_device_instances.ListDeviceInstancesInput, options: list_device_instances.Options) !list_device_instances.ListDeviceInstancesOutput {
        return list_device_instances.execute(self, allocator, input, options);
    }

    /// Gets information about device pools.
    pub fn listDevicePools(self: *Self, allocator: std.mem.Allocator, input: list_device_pools.ListDevicePoolsInput, options: list_device_pools.Options) !list_device_pools.ListDevicePoolsOutput {
        return list_device_pools.execute(self, allocator, input, options);
    }

    /// Gets information about unique device types.
    pub fn listDevices(self: *Self, allocator: std.mem.Allocator, input: list_devices.ListDevicesInput, options: list_devices.Options) !list_devices.ListDevicesOutput {
        return list_devices.execute(self, allocator, input, options);
    }

    /// Returns information about all the instance profiles in an AWS account.
    pub fn listInstanceProfiles(self: *Self, allocator: std.mem.Allocator, input: list_instance_profiles.ListInstanceProfilesInput, options: list_instance_profiles.Options) !list_instance_profiles.ListInstanceProfilesOutput {
        return list_instance_profiles.execute(self, allocator, input, options);
    }

    /// Gets information about jobs for a given test run.
    pub fn listJobs(self: *Self, allocator: std.mem.Allocator, input: list_jobs.ListJobsInput, options: list_jobs.Options) !list_jobs.ListJobsOutput {
        return list_jobs.execute(self, allocator, input, options);
    }

    /// Returns the list of available network profiles.
    pub fn listNetworkProfiles(self: *Self, allocator: std.mem.Allocator, input: list_network_profiles.ListNetworkProfilesInput, options: list_network_profiles.Options) !list_network_profiles.ListNetworkProfilesOutput {
        return list_network_profiles.execute(self, allocator, input, options);
    }

    /// Returns a list of offering promotions. Each offering promotion record
    /// contains the ID and description
    /// of the promotion. The API returns a `NotEligible` error if the caller is not
    /// permitted to invoke
    /// the operation. Contact
    /// [aws-devicefarm-support@amazon.com](mailto:aws-devicefarm-support@amazon.com) if you must be able to invoke this operation.
    pub fn listOfferingPromotions(self: *Self, allocator: std.mem.Allocator, input: list_offering_promotions.ListOfferingPromotionsInput, options: list_offering_promotions.Options) !list_offering_promotions.ListOfferingPromotionsOutput {
        return list_offering_promotions.execute(self, allocator, input, options);
    }

    /// Returns a list of all historical purchases, renewals, and system renewal
    /// transactions for an AWS
    /// account. The list is paginated and ordered by a descending timestamp (most
    /// recent transactions are first).
    /// The API returns a `NotEligible` error if the user is not permitted to invoke
    /// the operation. If
    /// you must be able to invoke this operation, contact
    /// [aws-devicefarm-support@amazon.com](mailto:aws-devicefarm-support@amazon.com).
    pub fn listOfferingTransactions(self: *Self, allocator: std.mem.Allocator, input: list_offering_transactions.ListOfferingTransactionsInput, options: list_offering_transactions.Options) !list_offering_transactions.ListOfferingTransactionsOutput {
        return list_offering_transactions.execute(self, allocator, input, options);
    }

    /// Returns a list of products or offerings that the user can manage through the
    /// API. Each offering record
    /// indicates the recurring price per unit and the frequency for that offering.
    /// The API returns a
    /// `NotEligible` error if the user is not permitted to invoke the operation. If
    /// you must be
    /// able to invoke this operation, contact
    /// [aws-devicefarm-support@amazon.com](mailto:aws-devicefarm-support@amazon.com).
    pub fn listOfferings(self: *Self, allocator: std.mem.Allocator, input: list_offerings.ListOfferingsInput, options: list_offerings.Options) !list_offerings.ListOfferingsOutput {
        return list_offerings.execute(self, allocator, input, options);
    }

    /// Gets information about projects.
    pub fn listProjects(self: *Self, allocator: std.mem.Allocator, input: list_projects.ListProjectsInput, options: list_projects.Options) !list_projects.ListProjectsOutput {
        return list_projects.execute(self, allocator, input, options);
    }

    /// Returns a list of all currently running remote access sessions.
    pub fn listRemoteAccessSessions(self: *Self, allocator: std.mem.Allocator, input: list_remote_access_sessions.ListRemoteAccessSessionsInput, options: list_remote_access_sessions.Options) !list_remote_access_sessions.ListRemoteAccessSessionsOutput {
        return list_remote_access_sessions.execute(self, allocator, input, options);
    }

    /// Gets information about runs, given an AWS Device Farm project ARN.
    pub fn listRuns(self: *Self, allocator: std.mem.Allocator, input: list_runs.ListRunsInput, options: list_runs.Options) !list_runs.ListRunsOutput {
        return list_runs.execute(self, allocator, input, options);
    }

    /// Gets information about samples, given an AWS Device Farm job ARN.
    pub fn listSamples(self: *Self, allocator: std.mem.Allocator, input: list_samples.ListSamplesInput, options: list_samples.Options) !list_samples.ListSamplesOutput {
        return list_samples.execute(self, allocator, input, options);
    }

    /// Gets information about test suites for a given job.
    pub fn listSuites(self: *Self, allocator: std.mem.Allocator, input: list_suites.ListSuitesInput, options: list_suites.Options) !list_suites.ListSuitesOutput {
        return list_suites.execute(self, allocator, input, options);
    }

    /// List the tags for an AWS Device Farm resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Gets a list of all Selenium testing projects in your account.
    pub fn listTestGridProjects(self: *Self, allocator: std.mem.Allocator, input: list_test_grid_projects.ListTestGridProjectsInput, options: list_test_grid_projects.Options) !list_test_grid_projects.ListTestGridProjectsOutput {
        return list_test_grid_projects.execute(self, allocator, input, options);
    }

    /// Returns a list of the actions taken in a TestGridSession.
    pub fn listTestGridSessionActions(self: *Self, allocator: std.mem.Allocator, input: list_test_grid_session_actions.ListTestGridSessionActionsInput, options: list_test_grid_session_actions.Options) !list_test_grid_session_actions.ListTestGridSessionActionsOutput {
        return list_test_grid_session_actions.execute(self, allocator, input, options);
    }

    /// Retrieves a list of artifacts created during the session.
    pub fn listTestGridSessionArtifacts(self: *Self, allocator: std.mem.Allocator, input: list_test_grid_session_artifacts.ListTestGridSessionArtifactsInput, options: list_test_grid_session_artifacts.Options) !list_test_grid_session_artifacts.ListTestGridSessionArtifactsOutput {
        return list_test_grid_session_artifacts.execute(self, allocator, input, options);
    }

    /// Retrieves a list of sessions for a TestGridProject.
    pub fn listTestGridSessions(self: *Self, allocator: std.mem.Allocator, input: list_test_grid_sessions.ListTestGridSessionsInput, options: list_test_grid_sessions.Options) !list_test_grid_sessions.ListTestGridSessionsOutput {
        return list_test_grid_sessions.execute(self, allocator, input, options);
    }

    /// Gets information about tests in a given test suite.
    pub fn listTests(self: *Self, allocator: std.mem.Allocator, input: list_tests.ListTestsInput, options: list_tests.Options) !list_tests.ListTestsOutput {
        return list_tests.execute(self, allocator, input, options);
    }

    /// Gets information about unique problems, such as exceptions or crashes.
    ///
    /// Unique problems are defined as a single instance of an error across a run,
    /// job, or suite. For example,
    /// if a call in your application consistently raises an exception
    /// (`OutOfBoundsException in
    /// MyActivity.java:386`), `ListUniqueProblems` returns a single entry instead
    /// of many
    /// individual entries for that exception.
    pub fn listUniqueProblems(self: *Self, allocator: std.mem.Allocator, input: list_unique_problems.ListUniqueProblemsInput, options: list_unique_problems.Options) !list_unique_problems.ListUniqueProblemsOutput {
        return list_unique_problems.execute(self, allocator, input, options);
    }

    /// Gets information about uploads, given an AWS Device Farm project ARN.
    pub fn listUploads(self: *Self, allocator: std.mem.Allocator, input: list_uploads.ListUploadsInput, options: list_uploads.Options) !list_uploads.ListUploadsOutput {
        return list_uploads.execute(self, allocator, input, options);
    }

    /// Returns information about all Amazon Virtual Private Cloud (VPC) endpoint
    /// configurations in the AWS account.
    pub fn listVpceConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_vpce_configurations.ListVPCEConfigurationsInput, options: list_vpce_configurations.Options) !list_vpce_configurations.ListVPCEConfigurationsOutput {
        return list_vpce_configurations.execute(self, allocator, input, options);
    }

    /// Immediately purchases offerings for an AWS account. Offerings renew with the
    /// latest total purchased
    /// quantity for an offering, unless the renewal was overridden. The API returns
    /// a `NotEligible`
    /// error if the user is not permitted to invoke the operation. If you must be
    /// able to invoke this operation,
    /// contact
    /// [aws-devicefarm-support@amazon.com](mailto:aws-devicefarm-support@amazon.com).
    pub fn purchaseOffering(self: *Self, allocator: std.mem.Allocator, input: purchase_offering.PurchaseOfferingInput, options: purchase_offering.Options) !purchase_offering.PurchaseOfferingOutput {
        return purchase_offering.execute(self, allocator, input, options);
    }

    /// Explicitly sets the quantity of devices to renew for an offering, starting
    /// from the
    /// `effectiveDate` of the next period. The API returns a `NotEligible` error if
    /// the
    /// user is not permitted to invoke the operation. If you must be able to invoke
    /// this operation, contact
    /// [aws-devicefarm-support@amazon.com](mailto:aws-devicefarm-support@amazon.com).
    pub fn renewOffering(self: *Self, allocator: std.mem.Allocator, input: renew_offering.RenewOfferingInput, options: renew_offering.Options) !renew_offering.RenewOfferingOutput {
        return renew_offering.execute(self, allocator, input, options);
    }

    /// Schedules a run.
    pub fn scheduleRun(self: *Self, allocator: std.mem.Allocator, input: schedule_run.ScheduleRunInput, options: schedule_run.Options) !schedule_run.ScheduleRunOutput {
        return schedule_run.execute(self, allocator, input, options);
    }

    /// Initiates a stop request for the current job. AWS Device Farm immediately
    /// stops the job on the device
    /// where tests have not started. You are not billed for this device. On the
    /// device where tests have started,
    /// setup suite and teardown suite tests run to completion on the device. You
    /// are billed for setup, teardown,
    /// and any tests that were in progress or already completed.
    pub fn stopJob(self: *Self, allocator: std.mem.Allocator, input: stop_job.StopJobInput, options: stop_job.Options) !stop_job.StopJobOutput {
        return stop_job.execute(self, allocator, input, options);
    }

    /// Ends a specified remote access session.
    pub fn stopRemoteAccessSession(self: *Self, allocator: std.mem.Allocator, input: stop_remote_access_session.StopRemoteAccessSessionInput, options: stop_remote_access_session.Options) !stop_remote_access_session.StopRemoteAccessSessionOutput {
        return stop_remote_access_session.execute(self, allocator, input, options);
    }

    /// Initiates a stop request for the current test run. AWS Device Farm
    /// immediately stops the run on devices
    /// where tests have not started. You are not billed for these devices. On
    /// devices where tests have started
    /// executing, setup suite and teardown suite tests run to completion on those
    /// devices. You are billed for
    /// setup, teardown, and any tests that were in progress or already completed.
    pub fn stopRun(self: *Self, allocator: std.mem.Allocator, input: stop_run.StopRunInput, options: stop_run.Options) !stop_run.StopRunOutput {
        return stop_run.execute(self, allocator, input, options);
    }

    /// Associates the specified tags to a resource with the specified
    /// `resourceArn`. If existing tags
    /// on a resource are not specified in the request parameters, they are not
    /// changed. When a resource is deleted,
    /// the tags associated with that resource are also deleted.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Deletes the specified tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates information about a private device instance.
    pub fn updateDeviceInstance(self: *Self, allocator: std.mem.Allocator, input: update_device_instance.UpdateDeviceInstanceInput, options: update_device_instance.Options) !update_device_instance.UpdateDeviceInstanceOutput {
        return update_device_instance.execute(self, allocator, input, options);
    }

    /// Modifies the name, description, and rules in a device pool given the
    /// attributes and
    /// the pool ARN. Rule updates are all-or-nothing, meaning they can only be
    /// updated as a
    /// whole (or not at all).
    pub fn updateDevicePool(self: *Self, allocator: std.mem.Allocator, input: update_device_pool.UpdateDevicePoolInput, options: update_device_pool.Options) !update_device_pool.UpdateDevicePoolOutput {
        return update_device_pool.execute(self, allocator, input, options);
    }

    /// Updates information about an existing private device instance profile.
    pub fn updateInstanceProfile(self: *Self, allocator: std.mem.Allocator, input: update_instance_profile.UpdateInstanceProfileInput, options: update_instance_profile.Options) !update_instance_profile.UpdateInstanceProfileOutput {
        return update_instance_profile.execute(self, allocator, input, options);
    }

    /// Updates the network profile.
    pub fn updateNetworkProfile(self: *Self, allocator: std.mem.Allocator, input: update_network_profile.UpdateNetworkProfileInput, options: update_network_profile.Options) !update_network_profile.UpdateNetworkProfileOutput {
        return update_network_profile.execute(self, allocator, input, options);
    }

    /// Modifies the specified project name, given the project ARN and a new
    /// name.
    pub fn updateProject(self: *Self, allocator: std.mem.Allocator, input: update_project.UpdateProjectInput, options: update_project.Options) !update_project.UpdateProjectOutput {
        return update_project.execute(self, allocator, input, options);
    }

    /// Change details of a project.
    pub fn updateTestGridProject(self: *Self, allocator: std.mem.Allocator, input: update_test_grid_project.UpdateTestGridProjectInput, options: update_test_grid_project.Options) !update_test_grid_project.UpdateTestGridProjectOutput {
        return update_test_grid_project.execute(self, allocator, input, options);
    }

    /// Updates an uploaded test spec.
    pub fn updateUpload(self: *Self, allocator: std.mem.Allocator, input: update_upload.UpdateUploadInput, options: update_upload.Options) !update_upload.UpdateUploadOutput {
        return update_upload.execute(self, allocator, input, options);
    }

    /// Updates information about an Amazon Virtual Private Cloud (VPC) endpoint
    /// configuration.
    pub fn updateVpceConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_vpce_configuration.UpdateVPCEConfigurationInput, options: update_vpce_configuration.Options) !update_vpce_configuration.UpdateVPCEConfigurationOutput {
        return update_vpce_configuration.execute(self, allocator, input, options);
    }

    pub fn getOfferingStatusPaginator(self: *Self, params: get_offering_status.GetOfferingStatusInput) paginator.GetOfferingStatusPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listArtifactsPaginator(self: *Self, params: list_artifacts.ListArtifactsInput) paginator.ListArtifactsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDevicePoolsPaginator(self: *Self, params: list_device_pools.ListDevicePoolsInput) paginator.ListDevicePoolsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDevicesPaginator(self: *Self, params: list_devices.ListDevicesInput) paginator.ListDevicesPaginator {
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

    pub fn listOfferingTransactionsPaginator(self: *Self, params: list_offering_transactions.ListOfferingTransactionsInput) paginator.ListOfferingTransactionsPaginator {
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

    pub fn listProjectsPaginator(self: *Self, params: list_projects.ListProjectsInput) paginator.ListProjectsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRunsPaginator(self: *Self, params: list_runs.ListRunsInput) paginator.ListRunsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSamplesPaginator(self: *Self, params: list_samples.ListSamplesInput) paginator.ListSamplesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSuitesPaginator(self: *Self, params: list_suites.ListSuitesInput) paginator.ListSuitesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTestGridProjectsPaginator(self: *Self, params: list_test_grid_projects.ListTestGridProjectsInput) paginator.ListTestGridProjectsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTestGridSessionActionsPaginator(self: *Self, params: list_test_grid_session_actions.ListTestGridSessionActionsInput) paginator.ListTestGridSessionActionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTestGridSessionArtifactsPaginator(self: *Self, params: list_test_grid_session_artifacts.ListTestGridSessionArtifactsInput) paginator.ListTestGridSessionArtifactsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTestGridSessionsPaginator(self: *Self, params: list_test_grid_sessions.ListTestGridSessionsInput) paginator.ListTestGridSessionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTestsPaginator(self: *Self, params: list_tests.ListTestsInput) paginator.ListTestsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listUniqueProblemsPaginator(self: *Self, params: list_unique_problems.ListUniqueProblemsInput) paginator.ListUniqueProblemsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listUploadsPaginator(self: *Self, params: list_uploads.ListUploadsInput) paginator.ListUploadsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
