const aws = @import("aws");
const std = @import("std");

const create_access = @import("create_access.zig");
const create_agreement = @import("create_agreement.zig");
const create_connector = @import("create_connector.zig");
const create_profile = @import("create_profile.zig");
const create_server = @import("create_server.zig");
const create_user = @import("create_user.zig");
const create_web_app = @import("create_web_app.zig");
const create_workflow = @import("create_workflow.zig");
const delete_access = @import("delete_access.zig");
const delete_agreement = @import("delete_agreement.zig");
const delete_certificate = @import("delete_certificate.zig");
const delete_connector = @import("delete_connector.zig");
const delete_host_key = @import("delete_host_key.zig");
const delete_profile = @import("delete_profile.zig");
const delete_server = @import("delete_server.zig");
const delete_ssh_public_key = @import("delete_ssh_public_key.zig");
const delete_user = @import("delete_user.zig");
const delete_web_app = @import("delete_web_app.zig");
const delete_web_app_customization = @import("delete_web_app_customization.zig");
const delete_workflow = @import("delete_workflow.zig");
const describe_access = @import("describe_access.zig");
const describe_agreement = @import("describe_agreement.zig");
const describe_certificate = @import("describe_certificate.zig");
const describe_connector = @import("describe_connector.zig");
const describe_execution = @import("describe_execution.zig");
const describe_host_key = @import("describe_host_key.zig");
const describe_profile = @import("describe_profile.zig");
const describe_security_policy = @import("describe_security_policy.zig");
const describe_server = @import("describe_server.zig");
const describe_user = @import("describe_user.zig");
const describe_web_app = @import("describe_web_app.zig");
const describe_web_app_customization = @import("describe_web_app_customization.zig");
const describe_workflow = @import("describe_workflow.zig");
const import_certificate = @import("import_certificate.zig");
const import_host_key = @import("import_host_key.zig");
const import_ssh_public_key = @import("import_ssh_public_key.zig");
const list_accesses = @import("list_accesses.zig");
const list_agreements = @import("list_agreements.zig");
const list_certificates = @import("list_certificates.zig");
const list_connectors = @import("list_connectors.zig");
const list_executions = @import("list_executions.zig");
const list_file_transfer_results = @import("list_file_transfer_results.zig");
const list_host_keys = @import("list_host_keys.zig");
const list_profiles = @import("list_profiles.zig");
const list_security_policies = @import("list_security_policies.zig");
const list_servers = @import("list_servers.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_users = @import("list_users.zig");
const list_web_apps = @import("list_web_apps.zig");
const list_workflows = @import("list_workflows.zig");
const send_workflow_step_state = @import("send_workflow_step_state.zig");
const start_directory_listing = @import("start_directory_listing.zig");
const start_file_transfer = @import("start_file_transfer.zig");
const start_remote_delete = @import("start_remote_delete.zig");
const start_remote_move = @import("start_remote_move.zig");
const start_server = @import("start_server.zig");
const stop_server = @import("stop_server.zig");
const tag_resource = @import("tag_resource.zig");
const test_connection = @import("test_connection.zig");
const test_identity_provider = @import("test_identity_provider.zig");
const untag_resource = @import("untag_resource.zig");
const update_access = @import("update_access.zig");
const update_agreement = @import("update_agreement.zig");
const update_certificate = @import("update_certificate.zig");
const update_connector = @import("update_connector.zig");
const update_host_key = @import("update_host_key.zig");
const update_profile = @import("update_profile.zig");
const update_server = @import("update_server.zig");
const update_user = @import("update_user.zig");
const update_web_app = @import("update_web_app.zig");
const update_web_app_customization = @import("update_web_app_customization.zig");
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Transfer";

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

    /// Used by administrators to choose which groups in the directory should have
    /// access to upload and download files over the enabled protocols using
    /// Transfer Family. For example, a Microsoft Active Directory might contain
    /// 50,000 users, but only a small fraction might need the ability to transfer
    /// files to the server. An administrator can use `CreateAccess` to limit the
    /// access to the correct set of users who need this ability.
    pub fn createAccess(self: *Self, allocator: std.mem.Allocator, input: create_access.CreateAccessInput, options: create_access.Options) !create_access.CreateAccessOutput {
        return create_access.execute(self, allocator, input, options);
    }

    /// Creates an agreement. An agreement is a bilateral trading partner agreement,
    /// or partnership, between an Transfer Family server and an AS2 process. The
    /// agreement defines the file and message transfer relationship between the
    /// server and the AS2 process. To define an agreement, Transfer Family combines
    /// a server, local profile, partner profile, certificate, and other attributes.
    ///
    /// The partner is identified with the `PartnerProfileId`, and the AS2 process
    /// is identified with the `LocalProfileId`.
    ///
    /// Specify *either* `BaseDirectory` or `CustomDirectories`, but not both.
    /// Specifying both causes the command to fail.
    pub fn createAgreement(self: *Self, allocator: std.mem.Allocator, input: create_agreement.CreateAgreementInput, options: create_agreement.Options) !create_agreement.CreateAgreementOutput {
        return create_agreement.execute(self, allocator, input, options);
    }

    /// Creates the connector, which captures the parameters for a connection for
    /// the AS2 or SFTP protocol. For AS2, the connector is required for sending
    /// files to an externally hosted AS2 server. For SFTP, the connector is
    /// required when sending files to an SFTP server or receiving files from an
    /// SFTP server. For more details about connectors, see [Configure AS2
    /// connectors](https://docs.aws.amazon.com/transfer/latest/userguide/configure-as2-connector.html) and [Create SFTP connectors](https://docs.aws.amazon.com/transfer/latest/userguide/configure-sftp-connector.html).
    ///
    /// You must specify exactly one configuration object: either for AS2
    /// (`As2Config`) or SFTP (`SftpConfig`).
    pub fn createConnector(self: *Self, allocator: std.mem.Allocator, input: create_connector.CreateConnectorInput, options: create_connector.Options) !create_connector.CreateConnectorOutput {
        return create_connector.execute(self, allocator, input, options);
    }

    /// Creates the local or partner profile to use for AS2 transfers.
    pub fn createProfile(self: *Self, allocator: std.mem.Allocator, input: create_profile.CreateProfileInput, options: create_profile.Options) !create_profile.CreateProfileOutput {
        return create_profile.execute(self, allocator, input, options);
    }

    /// Instantiates an auto-scaling virtual server based on the selected file
    /// transfer protocol in Amazon Web Services. When you make updates to your file
    /// transfer protocol-enabled server or when you work with users, use the
    /// service-generated `ServerId` property that is assigned to the newly created
    /// server.
    pub fn createServer(self: *Self, allocator: std.mem.Allocator, input: create_server.CreateServerInput, options: create_server.Options) !create_server.CreateServerOutput {
        return create_server.execute(self, allocator, input, options);
    }

    /// Creates a user and associates them with an existing file transfer
    /// protocol-enabled server. You can only create and associate users with
    /// servers that have the `IdentityProviderType` set to `SERVICE_MANAGED`. Using
    /// parameters for `CreateUser`, you can specify the user name, set the home
    /// directory, store the user's public key, and assign the user's Identity and
    /// Access Management (IAM) role. You can also optionally add a session policy,
    /// and assign metadata with tags that can be used to group and search for
    /// users.
    pub fn createUser(self: *Self, allocator: std.mem.Allocator, input: create_user.CreateUserInput, options: create_user.Options) !create_user.CreateUserOutput {
        return create_user.execute(self, allocator, input, options);
    }

    /// Creates a web app based on specified parameters, and returns the ID for the
    /// new web app. You can configure the web app to be publicly accessible or
    /// hosted within a VPC.
    ///
    /// For more information about using VPC endpoints with Transfer Family, see
    /// [Create a Transfer Family web app in a
    /// VPC](https://docs.aws.amazon.com/transfer/latest/userguide/create-webapp-in-vpc.html).
    pub fn createWebApp(self: *Self, allocator: std.mem.Allocator, input: create_web_app.CreateWebAppInput, options: create_web_app.Options) !create_web_app.CreateWebAppOutput {
        return create_web_app.execute(self, allocator, input, options);
    }

    /// Allows you to create a workflow with specified steps and step details the
    /// workflow invokes after file transfer completes. After creating a workflow,
    /// you can associate the workflow created with any transfer servers by
    /// specifying the `workflow-details` field in `CreateServer` and `UpdateServer`
    /// operations.
    pub fn createWorkflow(self: *Self, allocator: std.mem.Allocator, input: create_workflow.CreateWorkflowInput, options: create_workflow.Options) !create_workflow.CreateWorkflowOutput {
        return create_workflow.execute(self, allocator, input, options);
    }

    /// Allows you to delete the access specified in the `ServerID` and `ExternalID`
    /// parameters.
    pub fn deleteAccess(self: *Self, allocator: std.mem.Allocator, input: delete_access.DeleteAccessInput, options: delete_access.Options) !delete_access.DeleteAccessOutput {
        return delete_access.execute(self, allocator, input, options);
    }

    /// Delete the agreement that's specified in the provided `AgreementId`.
    pub fn deleteAgreement(self: *Self, allocator: std.mem.Allocator, input: delete_agreement.DeleteAgreementInput, options: delete_agreement.Options) !delete_agreement.DeleteAgreementOutput {
        return delete_agreement.execute(self, allocator, input, options);
    }

    /// Deletes the certificate that's specified in the `CertificateId` parameter.
    pub fn deleteCertificate(self: *Self, allocator: std.mem.Allocator, input: delete_certificate.DeleteCertificateInput, options: delete_certificate.Options) !delete_certificate.DeleteCertificateOutput {
        return delete_certificate.execute(self, allocator, input, options);
    }

    /// Deletes the connector that's specified in the provided `ConnectorId`.
    pub fn deleteConnector(self: *Self, allocator: std.mem.Allocator, input: delete_connector.DeleteConnectorInput, options: delete_connector.Options) !delete_connector.DeleteConnectorOutput {
        return delete_connector.execute(self, allocator, input, options);
    }

    /// Deletes the host key that's specified in the `HostKeyId` parameter.
    pub fn deleteHostKey(self: *Self, allocator: std.mem.Allocator, input: delete_host_key.DeleteHostKeyInput, options: delete_host_key.Options) !delete_host_key.DeleteHostKeyOutput {
        return delete_host_key.execute(self, allocator, input, options);
    }

    /// Deletes the profile that's specified in the `ProfileId` parameter.
    pub fn deleteProfile(self: *Self, allocator: std.mem.Allocator, input: delete_profile.DeleteProfileInput, options: delete_profile.Options) !delete_profile.DeleteProfileOutput {
        return delete_profile.execute(self, allocator, input, options);
    }

    /// Deletes the file transfer protocol-enabled server that you specify.
    ///
    /// No response returns from this operation.
    pub fn deleteServer(self: *Self, allocator: std.mem.Allocator, input: delete_server.DeleteServerInput, options: delete_server.Options) !delete_server.DeleteServerOutput {
        return delete_server.execute(self, allocator, input, options);
    }

    /// Deletes a user's Secure Shell (SSH) public key.
    pub fn deleteSshPublicKey(self: *Self, allocator: std.mem.Allocator, input: delete_ssh_public_key.DeleteSshPublicKeyInput, options: delete_ssh_public_key.Options) !delete_ssh_public_key.DeleteSshPublicKeyOutput {
        return delete_ssh_public_key.execute(self, allocator, input, options);
    }

    /// Deletes the user belonging to a file transfer protocol-enabled server you
    /// specify.
    ///
    /// No response returns from this operation.
    ///
    /// When you delete a user from a server, the user's information is lost.
    pub fn deleteUser(self: *Self, allocator: std.mem.Allocator, input: delete_user.DeleteUserInput, options: delete_user.Options) !delete_user.DeleteUserOutput {
        return delete_user.execute(self, allocator, input, options);
    }

    /// Deletes the specified web app.
    pub fn deleteWebApp(self: *Self, allocator: std.mem.Allocator, input: delete_web_app.DeleteWebAppInput, options: delete_web_app.Options) !delete_web_app.DeleteWebAppOutput {
        return delete_web_app.execute(self, allocator, input, options);
    }

    /// Deletes the `WebAppCustomization` object that corresponds to the web app ID
    /// specified.
    pub fn deleteWebAppCustomization(self: *Self, allocator: std.mem.Allocator, input: delete_web_app_customization.DeleteWebAppCustomizationInput, options: delete_web_app_customization.Options) !delete_web_app_customization.DeleteWebAppCustomizationOutput {
        return delete_web_app_customization.execute(self, allocator, input, options);
    }

    /// Deletes the specified workflow.
    pub fn deleteWorkflow(self: *Self, allocator: std.mem.Allocator, input: delete_workflow.DeleteWorkflowInput, options: delete_workflow.Options) !delete_workflow.DeleteWorkflowOutput {
        return delete_workflow.execute(self, allocator, input, options);
    }

    /// Describes the access that is assigned to the specific file transfer
    /// protocol-enabled server, as identified by its `ServerId` property and its
    /// `ExternalId`.
    ///
    /// The response from this call returns the properties of the access that is
    /// associated with the `ServerId` value that was specified.
    pub fn describeAccess(self: *Self, allocator: std.mem.Allocator, input: describe_access.DescribeAccessInput, options: describe_access.Options) !describe_access.DescribeAccessOutput {
        return describe_access.execute(self, allocator, input, options);
    }

    /// Describes the agreement that's identified by the `AgreementId`.
    pub fn describeAgreement(self: *Self, allocator: std.mem.Allocator, input: describe_agreement.DescribeAgreementInput, options: describe_agreement.Options) !describe_agreement.DescribeAgreementOutput {
        return describe_agreement.execute(self, allocator, input, options);
    }

    /// Describes the certificate that's identified by the `CertificateId`.
    ///
    /// Transfer Family automatically publishes a Amazon CloudWatch metric called
    /// `DaysUntilExpiry` for imported certificates. This metric tracks the number
    /// of days until the certificate expires based on the `InactiveDate`. The
    /// metric is available in the `AWS/Transfer` namespace and includes the
    /// `CertificateId` as a dimension.
    pub fn describeCertificate(self: *Self, allocator: std.mem.Allocator, input: describe_certificate.DescribeCertificateInput, options: describe_certificate.Options) !describe_certificate.DescribeCertificateOutput {
        return describe_certificate.execute(self, allocator, input, options);
    }

    /// Describes the connector that's identified by the `ConnectorId.`
    pub fn describeConnector(self: *Self, allocator: std.mem.Allocator, input: describe_connector.DescribeConnectorInput, options: describe_connector.Options) !describe_connector.DescribeConnectorOutput {
        return describe_connector.execute(self, allocator, input, options);
    }

    /// You can use `DescribeExecution` to check the details of the execution of the
    /// specified workflow.
    ///
    /// This API call only returns details for in-progress workflows.
    ///
    /// If you provide an ID for an execution that is not in progress, or if the
    /// execution doesn't match the specified workflow ID, you receive a
    /// `ResourceNotFound` exception.
    pub fn describeExecution(self: *Self, allocator: std.mem.Allocator, input: describe_execution.DescribeExecutionInput, options: describe_execution.Options) !describe_execution.DescribeExecutionOutput {
        return describe_execution.execute(self, allocator, input, options);
    }

    /// Returns the details of the host key that's specified by the `HostKeyId` and
    /// `ServerId`.
    pub fn describeHostKey(self: *Self, allocator: std.mem.Allocator, input: describe_host_key.DescribeHostKeyInput, options: describe_host_key.Options) !describe_host_key.DescribeHostKeyOutput {
        return describe_host_key.execute(self, allocator, input, options);
    }

    /// Returns the details of the profile that's specified by the `ProfileId`.
    pub fn describeProfile(self: *Self, allocator: std.mem.Allocator, input: describe_profile.DescribeProfileInput, options: describe_profile.Options) !describe_profile.DescribeProfileOutput {
        return describe_profile.execute(self, allocator, input, options);
    }

    /// Describes the security policy that is attached to your server or SFTP
    /// connector. The response contains a description of the security policy's
    /// properties. For more information about security policies, see [Working with
    /// security policies for
    /// servers](https://docs.aws.amazon.com/transfer/latest/userguide/security-policies.html) or [Working with security policies for SFTP connectors](https://docs.aws.amazon.com/transfer/latest/userguide/security-policies-connectors.html).
    pub fn describeSecurityPolicy(self: *Self, allocator: std.mem.Allocator, input: describe_security_policy.DescribeSecurityPolicyInput, options: describe_security_policy.Options) !describe_security_policy.DescribeSecurityPolicyOutput {
        return describe_security_policy.execute(self, allocator, input, options);
    }

    /// Describes a file transfer protocol-enabled server that you specify by
    /// passing the `ServerId` parameter.
    ///
    /// The response contains a description of a server's properties. When you set
    /// `EndpointType` to VPC, the response will contain the `EndpointDetails`.
    pub fn describeServer(self: *Self, allocator: std.mem.Allocator, input: describe_server.DescribeServerInput, options: describe_server.Options) !describe_server.DescribeServerOutput {
        return describe_server.execute(self, allocator, input, options);
    }

    /// Describes the user assigned to the specific file transfer protocol-enabled
    /// server, as identified by its `ServerId` property.
    ///
    /// The response from this call returns the properties of the user associated
    /// with the `ServerId` value that was specified.
    pub fn describeUser(self: *Self, allocator: std.mem.Allocator, input: describe_user.DescribeUserInput, options: describe_user.Options) !describe_user.DescribeUserOutput {
        return describe_user.execute(self, allocator, input, options);
    }

    /// Describes the web app that's identified by `WebAppId`. The response includes
    /// endpoint configuration details such as whether the web app is publicly
    /// accessible or VPC hosted.
    ///
    /// For more information about using VPC endpoints with Transfer Family, see
    /// [Create a Transfer Family web app in a
    /// VPC](https://docs.aws.amazon.com/transfer/latest/userguide/create-webapp-in-vpc.html).
    pub fn describeWebApp(self: *Self, allocator: std.mem.Allocator, input: describe_web_app.DescribeWebAppInput, options: describe_web_app.Options) !describe_web_app.DescribeWebAppOutput {
        return describe_web_app.execute(self, allocator, input, options);
    }

    /// Describes the web app customization object that's identified by `WebAppId`.
    pub fn describeWebAppCustomization(self: *Self, allocator: std.mem.Allocator, input: describe_web_app_customization.DescribeWebAppCustomizationInput, options: describe_web_app_customization.Options) !describe_web_app_customization.DescribeWebAppCustomizationOutput {
        return describe_web_app_customization.execute(self, allocator, input, options);
    }

    /// Describes the specified workflow.
    pub fn describeWorkflow(self: *Self, allocator: std.mem.Allocator, input: describe_workflow.DescribeWorkflowInput, options: describe_workflow.Options) !describe_workflow.DescribeWorkflowOutput {
        return describe_workflow.execute(self, allocator, input, options);
    }

    /// Imports the signing and encryption certificates that you need to create
    /// local (AS2) profiles and partner profiles.
    ///
    /// You can import both the certificate and its chain in the `Certificate`
    /// parameter.
    ///
    /// After importing a certificate, Transfer Family automatically creates a
    /// Amazon CloudWatch metric called `DaysUntilExpiry` that tracks the number of
    /// days until the certificate expires. The metric is based on the
    /// `InactiveDate` parameter and is published daily in the `AWS/Transfer`
    /// namespace.
    ///
    /// It can take up to a full day after importing a certificate for Transfer
    /// Family to emit the `DaysUntilExpiry` metric to your account.
    ///
    /// If you use the `Certificate` parameter to upload both the certificate and
    /// its chain, don't use the `CertificateChain` parameter.
    ///
    /// **CloudWatch monitoring**
    ///
    /// The `DaysUntilExpiry` metric includes the following specifications:
    ///
    /// * **Units:** Count (days)
    /// * **Dimensions:** `CertificateId` (always present), `Description` (if
    ///   provided during certificate import)
    /// * **Statistics:** Minimum, Maximum, Average
    /// * **Frequency:** Published daily
    pub fn importCertificate(self: *Self, allocator: std.mem.Allocator, input: import_certificate.ImportCertificateInput, options: import_certificate.Options) !import_certificate.ImportCertificateOutput {
        return import_certificate.execute(self, allocator, input, options);
    }

    /// Adds a host key to the server that's specified by the `ServerId` parameter.
    pub fn importHostKey(self: *Self, allocator: std.mem.Allocator, input: import_host_key.ImportHostKeyInput, options: import_host_key.Options) !import_host_key.ImportHostKeyOutput {
        return import_host_key.execute(self, allocator, input, options);
    }

    /// Adds a Secure Shell (SSH) public key to a Transfer Family user identified by
    /// a `UserName` value assigned to the specific file transfer protocol-enabled
    /// server, identified by `ServerId`.
    ///
    /// The response returns the `UserName` value, the `ServerId` value, and the
    /// name of the `SshPublicKeyId`.
    pub fn importSshPublicKey(self: *Self, allocator: std.mem.Allocator, input: import_ssh_public_key.ImportSshPublicKeyInput, options: import_ssh_public_key.Options) !import_ssh_public_key.ImportSshPublicKeyOutput {
        return import_ssh_public_key.execute(self, allocator, input, options);
    }

    /// Lists the details for all the accesses you have on your server.
    pub fn listAccesses(self: *Self, allocator: std.mem.Allocator, input: list_accesses.ListAccessesInput, options: list_accesses.Options) !list_accesses.ListAccessesOutput {
        return list_accesses.execute(self, allocator, input, options);
    }

    /// Returns a list of the agreements for the server that's identified by the
    /// `ServerId` that you supply. If you want to limit the results to a certain
    /// number, supply a value for the `MaxResults` parameter. If you ran the
    /// command previously and received a value for `NextToken`, you can supply that
    /// value to continue listing agreements from where you left off.
    pub fn listAgreements(self: *Self, allocator: std.mem.Allocator, input: list_agreements.ListAgreementsInput, options: list_agreements.Options) !list_agreements.ListAgreementsOutput {
        return list_agreements.execute(self, allocator, input, options);
    }

    /// Returns a list of the current certificates that have been imported into
    /// Transfer Family. If you want to limit the results to a certain number,
    /// supply a value for the `MaxResults` parameter. If you ran the command
    /// previously and received a value for the `NextToken` parameter, you can
    /// supply that value to continue listing certificates from where you left off.
    pub fn listCertificates(self: *Self, allocator: std.mem.Allocator, input: list_certificates.ListCertificatesInput, options: list_certificates.Options) !list_certificates.ListCertificatesOutput {
        return list_certificates.execute(self, allocator, input, options);
    }

    /// Lists the connectors for the specified Region.
    pub fn listConnectors(self: *Self, allocator: std.mem.Allocator, input: list_connectors.ListConnectorsInput, options: list_connectors.Options) !list_connectors.ListConnectorsOutput {
        return list_connectors.execute(self, allocator, input, options);
    }

    /// Lists all in-progress executions for the specified workflow.
    ///
    /// If the specified workflow ID cannot be found, `ListExecutions` returns a
    /// `ResourceNotFound` exception.
    pub fn listExecutions(self: *Self, allocator: std.mem.Allocator, input: list_executions.ListExecutionsInput, options: list_executions.Options) !list_executions.ListExecutionsOutput {
        return list_executions.execute(self, allocator, input, options);
    }

    /// Returns real-time updates and detailed information on the status of each
    /// individual file being transferred in a specific file transfer operation. You
    /// specify the file transfer by providing its `ConnectorId` and its
    /// `TransferId`.
    ///
    /// File transfer results are available up to 7 days after an operation has been
    /// requested.
    pub fn listFileTransferResults(self: *Self, allocator: std.mem.Allocator, input: list_file_transfer_results.ListFileTransferResultsInput, options: list_file_transfer_results.Options) !list_file_transfer_results.ListFileTransferResultsOutput {
        return list_file_transfer_results.execute(self, allocator, input, options);
    }

    /// Returns a list of host keys for the server that's specified by the
    /// `ServerId` parameter.
    pub fn listHostKeys(self: *Self, allocator: std.mem.Allocator, input: list_host_keys.ListHostKeysInput, options: list_host_keys.Options) !list_host_keys.ListHostKeysOutput {
        return list_host_keys.execute(self, allocator, input, options);
    }

    /// Returns a list of the profiles for your system. If you want to limit the
    /// results to a certain number, supply a value for the `MaxResults` parameter.
    /// If you ran the command previously and received a value for `NextToken`, you
    /// can supply that value to continue listing profiles from where you left off.
    pub fn listProfiles(self: *Self, allocator: std.mem.Allocator, input: list_profiles.ListProfilesInput, options: list_profiles.Options) !list_profiles.ListProfilesOutput {
        return list_profiles.execute(self, allocator, input, options);
    }

    /// Lists the security policies that are attached to your servers and SFTP
    /// connectors. For more information about security policies, see [Working with
    /// security policies for
    /// servers](https://docs.aws.amazon.com/transfer/latest/userguide/security-policies.html) or [Working with security policies for SFTP connectors](https://docs.aws.amazon.com/transfer/latest/userguide/security-policies-connectors.html).
    pub fn listSecurityPolicies(self: *Self, allocator: std.mem.Allocator, input: list_security_policies.ListSecurityPoliciesInput, options: list_security_policies.Options) !list_security_policies.ListSecurityPoliciesOutput {
        return list_security_policies.execute(self, allocator, input, options);
    }

    /// Lists the file transfer protocol-enabled servers that are associated with
    /// your Amazon Web Services account.
    pub fn listServers(self: *Self, allocator: std.mem.Allocator, input: list_servers.ListServersInput, options: list_servers.Options) !list_servers.ListServersOutput {
        return list_servers.execute(self, allocator, input, options);
    }

    /// Lists all of the tags associated with the Amazon Resource Name (ARN) that
    /// you specify. The resource can be a user, server, or role.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists the users for a file transfer protocol-enabled server that you specify
    /// by passing the `ServerId` parameter.
    pub fn listUsers(self: *Self, allocator: std.mem.Allocator, input: list_users.ListUsersInput, options: list_users.Options) !list_users.ListUsersOutput {
        return list_users.execute(self, allocator, input, options);
    }

    /// Lists all web apps associated with your Amazon Web Services account for your
    /// current region. The response includes the endpoint type for each web app,
    /// showing whether it is publicly accessible or VPC hosted.
    ///
    /// For more information about using VPC endpoints with Transfer Family, see
    /// [Create a Transfer Family web app in a
    /// VPC](https://docs.aws.amazon.com/transfer/latest/userguide/create-webapp-in-vpc.html).
    pub fn listWebApps(self: *Self, allocator: std.mem.Allocator, input: list_web_apps.ListWebAppsInput, options: list_web_apps.Options) !list_web_apps.ListWebAppsOutput {
        return list_web_apps.execute(self, allocator, input, options);
    }

    /// Lists all workflows associated with your Amazon Web Services account for
    /// your current region.
    pub fn listWorkflows(self: *Self, allocator: std.mem.Allocator, input: list_workflows.ListWorkflowsInput, options: list_workflows.Options) !list_workflows.ListWorkflowsOutput {
        return list_workflows.execute(self, allocator, input, options);
    }

    /// Sends a callback for asynchronous custom steps.
    ///
    /// The `ExecutionId`, `WorkflowId`, and `Token` are passed to the target
    /// resource during execution of a custom step of a workflow. You must include
    /// those with their callback as well as providing a status.
    pub fn sendWorkflowStepState(self: *Self, allocator: std.mem.Allocator, input: send_workflow_step_state.SendWorkflowStepStateInput, options: send_workflow_step_state.Options) !send_workflow_step_state.SendWorkflowStepStateOutput {
        return send_workflow_step_state.execute(self, allocator, input, options);
    }

    /// Retrieves a list of the contents of a directory from a remote SFTP server.
    /// You specify the connector ID, the output path, and the remote directory
    /// path. You can also specify the optional `MaxItems` value to control the
    /// maximum number of items that are listed from the remote directory. This API
    /// returns a list of all files and directories in the remote directory (up to
    /// the maximum value), but does not return files or folders in sub-directories.
    /// That is, it only returns a list of files and directories one-level deep.
    ///
    /// After you receive the listing file, you can provide the files that you want
    /// to transfer to the `RetrieveFilePaths` parameter of the `StartFileTransfer`
    /// API call.
    ///
    /// The naming convention for the output file is `
    /// *connector-ID*-*listing-ID*.json`. The output file contains the following
    /// information:
    ///
    /// * `filePath`: the complete path of a remote file, relative to the directory
    ///   of the listing request for your SFTP connector on the remote server.
    /// * `modifiedTimestamp`: the last time the file was modified, in UTC time
    ///   format. This field is optional. If the remote file attributes don't
    ///   contain a timestamp, it is omitted from the file listing.
    /// * `size`: the size of the file, in bytes. This field is optional. If the
    ///   remote file attributes don't contain a file size, it is omitted from the
    ///   file listing.
    /// * `path`: the complete path of a remote directory, relative to the directory
    ///   of the listing request for your SFTP connector on the remote server.
    /// * `truncated`: a flag indicating whether the list output contains all of the
    ///   items contained in the remote directory or not. If your `Truncated` output
    ///   value is true, you can increase the value provided in the optional
    ///   `max-items` input attribute to be able to list more items (up to the
    ///   maximum allowed list size of 10,000 items).
    pub fn startDirectoryListing(self: *Self, allocator: std.mem.Allocator, input: start_directory_listing.StartDirectoryListingInput, options: start_directory_listing.Options) !start_directory_listing.StartDirectoryListingOutput {
        return start_directory_listing.execute(self, allocator, input, options);
    }

    /// Begins a file transfer between local Amazon Web Services storage and a
    /// remote AS2 or SFTP server.
    ///
    /// * For an AS2 connector, you specify the `ConnectorId` and one or more
    ///   `SendFilePaths` to identify the files you want to transfer.
    /// * For an SFTP connector, the file transfer can be either outbound or
    ///   inbound. In both cases, you specify the `ConnectorId`. Depending on the
    ///   direction of the transfer, you also specify the following items:
    ///
    /// * If you are transferring file from a partner's SFTP server to Amazon Web
    ///   Services storage, you specify one or more `RetrieveFilePaths` to identify
    ///   the files you want to transfer, and a `LocalDirectoryPath` to specify the
    ///   destination folder.
    /// * If you are transferring file to a partner's SFTP server from Amazon Web
    ///   Services storage, you specify one or more `SendFilePaths` to identify the
    ///   files you want to transfer, and a `RemoteDirectoryPath` to specify the
    ///   destination folder.
    pub fn startFileTransfer(self: *Self, allocator: std.mem.Allocator, input: start_file_transfer.StartFileTransferInput, options: start_file_transfer.Options) !start_file_transfer.StartFileTransferOutput {
        return start_file_transfer.execute(self, allocator, input, options);
    }

    /// Deletes a file or directory on the remote SFTP server.
    pub fn startRemoteDelete(self: *Self, allocator: std.mem.Allocator, input: start_remote_delete.StartRemoteDeleteInput, options: start_remote_delete.Options) !start_remote_delete.StartRemoteDeleteOutput {
        return start_remote_delete.execute(self, allocator, input, options);
    }

    /// Moves or renames a file or directory on the remote SFTP server.
    pub fn startRemoteMove(self: *Self, allocator: std.mem.Allocator, input: start_remote_move.StartRemoteMoveInput, options: start_remote_move.Options) !start_remote_move.StartRemoteMoveOutput {
        return start_remote_move.execute(self, allocator, input, options);
    }

    /// Changes the state of a file transfer protocol-enabled server from `OFFLINE`
    /// to `ONLINE`. It has no impact on a server that is already `ONLINE`. An
    /// `ONLINE` server can accept and process file transfer jobs.
    ///
    /// The state of `STARTING` indicates that the server is in an intermediate
    /// state, either not fully able to respond, or not fully online. The values of
    /// `START_FAILED` can indicate an error condition.
    ///
    /// No response is returned from this call.
    pub fn startServer(self: *Self, allocator: std.mem.Allocator, input: start_server.StartServerInput, options: start_server.Options) !start_server.StartServerOutput {
        return start_server.execute(self, allocator, input, options);
    }

    /// Changes the state of a file transfer protocol-enabled server from `ONLINE`
    /// to `OFFLINE`. An `OFFLINE` server cannot accept and process file transfer
    /// jobs. Information tied to your server, such as server and user properties,
    /// are not affected by stopping your server.
    ///
    /// Stopping the server does not reduce or impact your file transfer protocol
    /// endpoint billing; you must delete the server to stop being billed.
    ///
    /// The state of `STOPPING` indicates that the server is in an intermediate
    /// state, either not fully able to respond, or not fully offline. The values of
    /// `STOP_FAILED` can indicate an error condition.
    ///
    /// No response is returned from this call.
    pub fn stopServer(self: *Self, allocator: std.mem.Allocator, input: stop_server.StopServerInput, options: stop_server.Options) !stop_server.StopServerOutput {
        return stop_server.execute(self, allocator, input, options);
    }

    /// Attaches a key-value pair to a resource, as identified by its Amazon
    /// Resource Name (ARN). Resources are users, servers, roles, and other
    /// entities.
    ///
    /// There is no response returned from this call.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Tests whether your SFTP connector is set up successfully. We highly
    /// recommend that you call this operation to test your ability to transfer
    /// files between local Amazon Web Services storage and a trading partner's SFTP
    /// server.
    pub fn testConnection(self: *Self, allocator: std.mem.Allocator, input: test_connection.TestConnectionInput, options: test_connection.Options) !test_connection.TestConnectionOutput {
        return test_connection.execute(self, allocator, input, options);
    }

    /// If the `IdentityProviderType` of a file transfer protocol-enabled server is
    /// `AWS_DIRECTORY_SERVICE` or `API_Gateway`, tests whether your identity
    /// provider is set up successfully. We highly recommend that you call this
    /// operation to test your authentication method as soon as you create your
    /// server. By doing so, you can troubleshoot issues with the identity provider
    /// integration to ensure that your users can successfully use the service.
    ///
    /// The `ServerId` and `UserName` parameters are required. The `ServerProtocol`,
    /// `SourceIp`, and `UserPassword` are all optional.
    ///
    /// Note the following:
    ///
    /// * You cannot use `TestIdentityProvider` if the `IdentityProviderType` of
    ///   your server is `SERVICE_MANAGED`.
    /// * `TestIdentityProvider` does not work with keys: it only accepts passwords.
    /// * `TestIdentityProvider` can test the password operation for a custom
    ///   Identity Provider that handles keys and passwords.
    /// * If you provide any incorrect values for any parameters, the `Response`
    ///   field is empty.
    /// * If you provide a server ID for a server that uses service-managed users,
    ///   you get an error:
    ///
    /// ` An error occurred (InvalidRequestException) when calling the
    /// TestIdentityProvider operation: s-*server-ID* not configured for external
    /// auth `
    /// * If you enter a Server ID for the `--server-id` parameter that does not
    ///   identify an actual Transfer server, you receive the following error:
    ///
    /// `An error occurred (ResourceNotFoundException) when calling the
    /// TestIdentityProvider operation: Unknown server`.
    ///
    /// It is possible your sever is in a different region. You can specify a region
    /// by adding the following: `--region region-code`, such as `--region
    /// us-east-2` to specify a server in **US East (Ohio)**.
    pub fn testIdentityProvider(self: *Self, allocator: std.mem.Allocator, input: test_identity_provider.TestIdentityProviderInput, options: test_identity_provider.Options) !test_identity_provider.TestIdentityProviderOutput {
        return test_identity_provider.execute(self, allocator, input, options);
    }

    /// Detaches a key-value pair from a resource, as identified by its Amazon
    /// Resource Name (ARN). Resources are users, servers, roles, and other
    /// entities.
    ///
    /// No response is returned from this call.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Allows you to update parameters for the access specified in the `ServerID`
    /// and `ExternalID` parameters.
    pub fn updateAccess(self: *Self, allocator: std.mem.Allocator, input: update_access.UpdateAccessInput, options: update_access.Options) !update_access.UpdateAccessOutput {
        return update_access.execute(self, allocator, input, options);
    }

    /// Updates some of the parameters for an existing agreement. Provide the
    /// `AgreementId` and the `ServerId` for the agreement that you want to update,
    /// along with the new values for the parameters to update.
    ///
    /// Specify *either* `BaseDirectory` or `CustomDirectories`, but not both.
    /// Specifying both causes the command to fail.
    ///
    /// If you update an agreement from using base directory to custom directories,
    /// the base directory is no longer used. Similarly, if you change from custom
    /// directories to a base directory, the custom directories are no longer used.
    pub fn updateAgreement(self: *Self, allocator: std.mem.Allocator, input: update_agreement.UpdateAgreementInput, options: update_agreement.Options) !update_agreement.UpdateAgreementOutput {
        return update_agreement.execute(self, allocator, input, options);
    }

    /// Updates the active and inactive dates for a certificate.
    pub fn updateCertificate(self: *Self, allocator: std.mem.Allocator, input: update_certificate.UpdateCertificateInput, options: update_certificate.Options) !update_certificate.UpdateCertificateOutput {
        return update_certificate.execute(self, allocator, input, options);
    }

    /// Updates some of the parameters for an existing connector. Provide the
    /// `ConnectorId` for the connector that you want to update, along with the new
    /// values for the parameters to update.
    pub fn updateConnector(self: *Self, allocator: std.mem.Allocator, input: update_connector.UpdateConnectorInput, options: update_connector.Options) !update_connector.UpdateConnectorOutput {
        return update_connector.execute(self, allocator, input, options);
    }

    /// Updates the description for the host key that's specified by the `ServerId`
    /// and `HostKeyId` parameters.
    pub fn updateHostKey(self: *Self, allocator: std.mem.Allocator, input: update_host_key.UpdateHostKeyInput, options: update_host_key.Options) !update_host_key.UpdateHostKeyOutput {
        return update_host_key.execute(self, allocator, input, options);
    }

    /// Updates some of the parameters for an existing profile. Provide the
    /// `ProfileId` for the profile that you want to update, along with the new
    /// values for the parameters to update.
    pub fn updateProfile(self: *Self, allocator: std.mem.Allocator, input: update_profile.UpdateProfileInput, options: update_profile.Options) !update_profile.UpdateProfileOutput {
        return update_profile.execute(self, allocator, input, options);
    }

    /// Updates the file transfer protocol-enabled server's properties after that
    /// server has been created.
    ///
    /// The `UpdateServer` call returns the `ServerId` of the server you updated.
    pub fn updateServer(self: *Self, allocator: std.mem.Allocator, input: update_server.UpdateServerInput, options: update_server.Options) !update_server.UpdateServerOutput {
        return update_server.execute(self, allocator, input, options);
    }

    /// Assigns new properties to a user. Parameters you pass modify any or all of
    /// the following: the home directory, role, and policy for the `UserName` and
    /// `ServerId` you specify.
    ///
    /// The response returns the `ServerId` and the `UserName` for the updated user.
    ///
    /// In the console, you can select *Restricted* when you create or update a
    /// user. This ensures that the user can't access anything outside of their home
    /// directory. The programmatic way to configure this behavior is to update the
    /// user. Set their `HomeDirectoryType` to `LOGICAL`, and specify
    /// `HomeDirectoryMappings` with `Entry` as root (`/`) and `Target` as their
    /// home directory.
    ///
    /// For example, if the user's home directory is `/test/admin-user`, the
    /// following command updates the user so that their configuration in the
    /// console shows the *Restricted* flag as selected.
    ///
    /// ` aws transfer update-user --server-id <server-id> --user-name admin-user
    /// --home-directory-type LOGICAL --home-directory-mappings "[{\"Entry\":\"/\",
    /// \"Target\":\"/test/admin-user\"}]"`
    pub fn updateUser(self: *Self, allocator: std.mem.Allocator, input: update_user.UpdateUserInput, options: update_user.Options) !update_user.UpdateUserOutput {
        return update_user.execute(self, allocator, input, options);
    }

    /// Assigns new properties to a web app. You can modify the access point,
    /// identity provider details, endpoint configuration, and the web app units.
    ///
    /// For more information about using VPC endpoints with Transfer Family, see
    /// [Create a Transfer Family web app in a
    /// VPC](https://docs.aws.amazon.com/transfer/latest/userguide/create-webapp-in-vpc.html).
    pub fn updateWebApp(self: *Self, allocator: std.mem.Allocator, input: update_web_app.UpdateWebAppInput, options: update_web_app.Options) !update_web_app.UpdateWebAppOutput {
        return update_web_app.execute(self, allocator, input, options);
    }

    /// Assigns new customization properties to a web app. You can modify the icon
    /// file, logo file, and title.
    pub fn updateWebAppCustomization(self: *Self, allocator: std.mem.Allocator, input: update_web_app_customization.UpdateWebAppCustomizationInput, options: update_web_app_customization.Options) !update_web_app_customization.UpdateWebAppCustomizationOutput {
        return update_web_app_customization.execute(self, allocator, input, options);
    }

    pub fn listAccessesPaginator(self: *Self, params: list_accesses.ListAccessesInput) paginator.ListAccessesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAgreementsPaginator(self: *Self, params: list_agreements.ListAgreementsInput) paginator.ListAgreementsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCertificatesPaginator(self: *Self, params: list_certificates.ListCertificatesInput) paginator.ListCertificatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listConnectorsPaginator(self: *Self, params: list_connectors.ListConnectorsInput) paginator.ListConnectorsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listExecutionsPaginator(self: *Self, params: list_executions.ListExecutionsInput) paginator.ListExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFileTransferResultsPaginator(self: *Self, params: list_file_transfer_results.ListFileTransferResultsInput) paginator.ListFileTransferResultsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listProfilesPaginator(self: *Self, params: list_profiles.ListProfilesInput) paginator.ListProfilesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSecurityPoliciesPaginator(self: *Self, params: list_security_policies.ListSecurityPoliciesInput) paginator.ListSecurityPoliciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServersPaginator(self: *Self, params: list_servers.ListServersInput) paginator.ListServersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTagsForResourcePaginator(self: *Self, params: list_tags_for_resource.ListTagsForResourceInput) paginator.ListTagsForResourcePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listUsersPaginator(self: *Self, params: list_users.ListUsersInput) paginator.ListUsersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWebAppsPaginator(self: *Self, params: list_web_apps.ListWebAppsInput) paginator.ListWebAppsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWorkflowsPaginator(self: *Self, params: list_workflows.ListWorkflowsInput) paginator.ListWorkflowsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilServerOffline(self: *Self, params: describe_server.DescribeServerInput) aws.waiter.WaiterError!void {
        var w = waiters.ServerOfflineWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilServerOnline(self: *Self, params: describe_server.DescribeServerInput) aws.waiter.WaiterError!void {
        var w = waiters.ServerOnlineWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
