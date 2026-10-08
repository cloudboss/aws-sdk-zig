const aws = @import("aws");
const std = @import("std");

const add_artifact = @import("add_artifact.zig");
const batch_create_security_requirements = @import("batch_create_security_requirements.zig");
const batch_delete_code_reviews = @import("batch_delete_code_reviews.zig");
const batch_delete_pentests = @import("batch_delete_pentests.zig");
const batch_delete_security_requirements = @import("batch_delete_security_requirements.zig");
const batch_delete_threat_models = @import("batch_delete_threat_models.zig");
const batch_get_agent_spaces = @import("batch_get_agent_spaces.zig");
const batch_get_artifact_metadata = @import("batch_get_artifact_metadata.zig");
const batch_get_code_review_job_tasks = @import("batch_get_code_review_job_tasks.zig");
const batch_get_code_review_jobs = @import("batch_get_code_review_jobs.zig");
const batch_get_code_reviews = @import("batch_get_code_reviews.zig");
const batch_get_findings = @import("batch_get_findings.zig");
const batch_get_pentest_job_tasks = @import("batch_get_pentest_job_tasks.zig");
const batch_get_pentest_jobs = @import("batch_get_pentest_jobs.zig");
const batch_get_pentests = @import("batch_get_pentests.zig");
const batch_get_security_requirements = @import("batch_get_security_requirements.zig");
const batch_get_target_domains = @import("batch_get_target_domains.zig");
const batch_get_threat_model_job_tasks = @import("batch_get_threat_model_job_tasks.zig");
const batch_get_threat_model_jobs = @import("batch_get_threat_model_jobs.zig");
const batch_get_threat_models = @import("batch_get_threat_models.zig");
const batch_get_threats = @import("batch_get_threats.zig");
const batch_update_security_requirements = @import("batch_update_security_requirements.zig");
const create_agent_space = @import("create_agent_space.zig");
const create_application = @import("create_application.zig");
const create_code_review = @import("create_code_review.zig");
const create_integration = @import("create_integration.zig");
const create_membership = @import("create_membership.zig");
const create_pentest = @import("create_pentest.zig");
const create_private_connection = @import("create_private_connection.zig");
const create_security_requirement_pack = @import("create_security_requirement_pack.zig");
const create_target_domain = @import("create_target_domain.zig");
const create_threat = @import("create_threat.zig");
const create_threat_model = @import("create_threat_model.zig");
const delete_agent_space = @import("delete_agent_space.zig");
const delete_application = @import("delete_application.zig");
const delete_artifact = @import("delete_artifact.zig");
const delete_integration = @import("delete_integration.zig");
const delete_membership = @import("delete_membership.zig");
const delete_private_connection = @import("delete_private_connection.zig");
const delete_security_requirement_pack = @import("delete_security_requirement_pack.zig");
const delete_target_domain = @import("delete_target_domain.zig");
const describe_private_connection = @import("describe_private_connection.zig");
const get_application = @import("get_application.zig");
const get_artifact = @import("get_artifact.zig");
const get_integration = @import("get_integration.zig");
const get_security_requirement_pack = @import("get_security_requirement_pack.zig");
const import_security_requirements = @import("import_security_requirements.zig");
const initiate_provider_registration = @import("initiate_provider_registration.zig");
const list_actor_messages = @import("list_actor_messages.zig");
const list_agent_spaces = @import("list_agent_spaces.zig");
const list_applications = @import("list_applications.zig");
const list_artifacts = @import("list_artifacts.zig");
const list_code_review_job_tasks = @import("list_code_review_job_tasks.zig");
const list_code_review_jobs_for_code_review = @import("list_code_review_jobs_for_code_review.zig");
const list_code_reviews = @import("list_code_reviews.zig");
const list_discovered_endpoints = @import("list_discovered_endpoints.zig");
const list_findings = @import("list_findings.zig");
const list_integrated_resources = @import("list_integrated_resources.zig");
const list_integrations = @import("list_integrations.zig");
const list_memberships = @import("list_memberships.zig");
const list_pentest_job_tasks = @import("list_pentest_job_tasks.zig");
const list_pentest_jobs_for_pentest = @import("list_pentest_jobs_for_pentest.zig");
const list_pentests = @import("list_pentests.zig");
const list_private_connections = @import("list_private_connections.zig");
const list_security_requirement_packs = @import("list_security_requirement_packs.zig");
const list_security_requirements = @import("list_security_requirements.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_target_domains = @import("list_target_domains.zig");
const list_threat_model_job_tasks = @import("list_threat_model_job_tasks.zig");
const list_threat_model_jobs = @import("list_threat_model_jobs.zig");
const list_threat_models = @import("list_threat_models.zig");
const list_threats = @import("list_threats.zig");
const start_code_remediation = @import("start_code_remediation.zig");
const start_code_review_job = @import("start_code_review_job.zig");
const start_pentest_job = @import("start_pentest_job.zig");
const start_threat_model_job = @import("start_threat_model_job.zig");
const stop_code_review_job = @import("stop_code_review_job.zig");
const stop_pentest_job = @import("stop_pentest_job.zig");
const stop_threat_model_job = @import("stop_threat_model_job.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_agent_space = @import("update_agent_space.zig");
const update_application = @import("update_application.zig");
const update_code_review = @import("update_code_review.zig");
const update_finding = @import("update_finding.zig");
const update_integrated_resources = @import("update_integrated_resources.zig");
const update_integration = @import("update_integration.zig");
const update_pentest = @import("update_pentest.zig");
const update_private_connection_certificate = @import("update_private_connection_certificate.zig");
const update_security_requirement_pack = @import("update_security_requirement_pack.zig");
const update_target_domain = @import("update_target_domain.zig");
const update_threat = @import("update_threat.zig");
const update_threat_model = @import("update_threat_model.zig");
const verify_target_domain = @import("verify_target_domain.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    options: aws.http.RequestOptions = .{},

    const Self = @This();
    pub const sdk_id = "SecurityAgent";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .options = options,
        };
    }

    pub fn deinit(self: *Self) void {
        _ = self;
    }

    /// Uploads an artifact to an agent space. Artifacts provide additional context
    /// for security testing, such as architecture diagrams, API specifications, or
    /// configuration files.
    pub fn addArtifact(self: *Self, allocator: std.mem.Allocator, input: add_artifact.AddArtifactInput, options: CallOptions) !add_artifact.AddArtifactOutput {
        return add_artifact.execute(self, allocator, input, options);
    }

    /// Batch creates security requirements in a customer managed pack.
    pub fn batchCreateSecurityRequirements(self: *Self, allocator: std.mem.Allocator, input: batch_create_security_requirements.BatchCreateSecurityRequirementsInput, options: CallOptions) !batch_create_security_requirements.BatchCreateSecurityRequirementsOutput {
        return batch_create_security_requirements.execute(self, allocator, input, options);
    }

    /// Deletes one or more code reviews from an agent space.
    pub fn batchDeleteCodeReviews(self: *Self, allocator: std.mem.Allocator, input: batch_delete_code_reviews.BatchDeleteCodeReviewsInput, options: CallOptions) !batch_delete_code_reviews.BatchDeleteCodeReviewsOutput {
        return batch_delete_code_reviews.execute(self, allocator, input, options);
    }

    /// Deletes one or more pentests from an agent space.
    pub fn batchDeletePentests(self: *Self, allocator: std.mem.Allocator, input: batch_delete_pentests.BatchDeletePentestsInput, options: CallOptions) !batch_delete_pentests.BatchDeletePentestsOutput {
        return batch_delete_pentests.execute(self, allocator, input, options);
    }

    /// Batch deletes security requirements from a customer managed pack.
    pub fn batchDeleteSecurityRequirements(self: *Self, allocator: std.mem.Allocator, input: batch_delete_security_requirements.BatchDeleteSecurityRequirementsInput, options: CallOptions) !batch_delete_security_requirements.BatchDeleteSecurityRequirementsOutput {
        return batch_delete_security_requirements.execute(self, allocator, input, options);
    }

    /// Deletes one or more threat models from an agent space.
    pub fn batchDeleteThreatModels(self: *Self, allocator: std.mem.Allocator, input: batch_delete_threat_models.BatchDeleteThreatModelsInput, options: CallOptions) !batch_delete_threat_models.BatchDeleteThreatModelsOutput {
        return batch_delete_threat_models.execute(self, allocator, input, options);
    }

    /// Retrieves information about one or more agent spaces.
    pub fn batchGetAgentSpaces(self: *Self, allocator: std.mem.Allocator, input: batch_get_agent_spaces.BatchGetAgentSpacesInput, options: CallOptions) !batch_get_agent_spaces.BatchGetAgentSpacesOutput {
        return batch_get_agent_spaces.execute(self, allocator, input, options);
    }

    /// Retrieves metadata for one or more artifacts in an agent space.
    pub fn batchGetArtifactMetadata(self: *Self, allocator: std.mem.Allocator, input: batch_get_artifact_metadata.BatchGetArtifactMetadataInput, options: CallOptions) !batch_get_artifact_metadata.BatchGetArtifactMetadataOutput {
        return batch_get_artifact_metadata.execute(self, allocator, input, options);
    }

    /// Retrieves information about one or more tasks within a code review job.
    pub fn batchGetCodeReviewJobTasks(self: *Self, allocator: std.mem.Allocator, input: batch_get_code_review_job_tasks.BatchGetCodeReviewJobTasksInput, options: CallOptions) !batch_get_code_review_job_tasks.BatchGetCodeReviewJobTasksOutput {
        return batch_get_code_review_job_tasks.execute(self, allocator, input, options);
    }

    /// Retrieves information about one or more code review jobs in an agent space.
    pub fn batchGetCodeReviewJobs(self: *Self, allocator: std.mem.Allocator, input: batch_get_code_review_jobs.BatchGetCodeReviewJobsInput, options: CallOptions) !batch_get_code_review_jobs.BatchGetCodeReviewJobsOutput {
        return batch_get_code_review_jobs.execute(self, allocator, input, options);
    }

    /// Retrieves information about one or more code reviews in an agent space.
    pub fn batchGetCodeReviews(self: *Self, allocator: std.mem.Allocator, input: batch_get_code_reviews.BatchGetCodeReviewsInput, options: CallOptions) !batch_get_code_reviews.BatchGetCodeReviewsOutput {
        return batch_get_code_reviews.execute(self, allocator, input, options);
    }

    /// Retrieves information about one or more security findings in an agent space.
    pub fn batchGetFindings(self: *Self, allocator: std.mem.Allocator, input: batch_get_findings.BatchGetFindingsInput, options: CallOptions) !batch_get_findings.BatchGetFindingsOutput {
        return batch_get_findings.execute(self, allocator, input, options);
    }

    /// Retrieves information about one or more tasks within a pentest job.
    pub fn batchGetPentestJobTasks(self: *Self, allocator: std.mem.Allocator, input: batch_get_pentest_job_tasks.BatchGetPentestJobTasksInput, options: CallOptions) !batch_get_pentest_job_tasks.BatchGetPentestJobTasksOutput {
        return batch_get_pentest_job_tasks.execute(self, allocator, input, options);
    }

    /// Retrieves information about one or more pentest jobs in an agent space.
    pub fn batchGetPentestJobs(self: *Self, allocator: std.mem.Allocator, input: batch_get_pentest_jobs.BatchGetPentestJobsInput, options: CallOptions) !batch_get_pentest_jobs.BatchGetPentestJobsOutput {
        return batch_get_pentest_jobs.execute(self, allocator, input, options);
    }

    /// Retrieves information about one or more pentests in an agent space.
    pub fn batchGetPentests(self: *Self, allocator: std.mem.Allocator, input: batch_get_pentests.BatchGetPentestsInput, options: CallOptions) !batch_get_pentests.BatchGetPentestsOutput {
        return batch_get_pentests.execute(self, allocator, input, options);
    }

    /// Batch retrieves security requirements from a pack.
    pub fn batchGetSecurityRequirements(self: *Self, allocator: std.mem.Allocator, input: batch_get_security_requirements.BatchGetSecurityRequirementsInput, options: CallOptions) !batch_get_security_requirements.BatchGetSecurityRequirementsOutput {
        return batch_get_security_requirements.execute(self, allocator, input, options);
    }

    /// Retrieves information about one or more target domains.
    pub fn batchGetTargetDomains(self: *Self, allocator: std.mem.Allocator, input: batch_get_target_domains.BatchGetTargetDomainsInput, options: CallOptions) !batch_get_target_domains.BatchGetTargetDomainsOutput {
        return batch_get_target_domains.execute(self, allocator, input, options);
    }

    /// Retrieves information about one or more tasks within a threat model job.
    pub fn batchGetThreatModelJobTasks(self: *Self, allocator: std.mem.Allocator, input: batch_get_threat_model_job_tasks.BatchGetThreatModelJobTasksInput, options: CallOptions) !batch_get_threat_model_job_tasks.BatchGetThreatModelJobTasksOutput {
        return batch_get_threat_model_job_tasks.execute(self, allocator, input, options);
    }

    /// Retrieves information about one or more threat model jobs in an agent space.
    pub fn batchGetThreatModelJobs(self: *Self, allocator: std.mem.Allocator, input: batch_get_threat_model_jobs.BatchGetThreatModelJobsInput, options: CallOptions) !batch_get_threat_model_jobs.BatchGetThreatModelJobsOutput {
        return batch_get_threat_model_jobs.execute(self, allocator, input, options);
    }

    /// Retrieves information about one or more threat models in an agent space.
    pub fn batchGetThreatModels(self: *Self, allocator: std.mem.Allocator, input: batch_get_threat_models.BatchGetThreatModelsInput, options: CallOptions) !batch_get_threat_models.BatchGetThreatModelsOutput {
        return batch_get_threat_models.execute(self, allocator, input, options);
    }

    /// Retrieves information about one or more threats.
    pub fn batchGetThreats(self: *Self, allocator: std.mem.Allocator, input: batch_get_threats.BatchGetThreatsInput, options: CallOptions) !batch_get_threats.BatchGetThreatsOutput {
        return batch_get_threats.execute(self, allocator, input, options);
    }

    /// Batch updates security requirements within a customer managed pack.
    pub fn batchUpdateSecurityRequirements(self: *Self, allocator: std.mem.Allocator, input: batch_update_security_requirements.BatchUpdateSecurityRequirementsInput, options: CallOptions) !batch_update_security_requirements.BatchUpdateSecurityRequirementsOutput {
        return batch_update_security_requirements.execute(self, allocator, input, options);
    }

    /// Creates a new agent space. An agent space is a dedicated workspace for
    /// securing a specific application.
    pub fn createAgentSpace(self: *Self, allocator: std.mem.Allocator, input: create_agent_space.CreateAgentSpaceInput, options: CallOptions) !create_agent_space.CreateAgentSpaceOutput {
        return create_agent_space.execute(self, allocator, input, options);
    }

    /// Creates a new application. An application is the top-level organizational
    /// unit that supports IAM Identity Center integration.
    pub fn createApplication(self: *Self, allocator: std.mem.Allocator, input: create_application.CreateApplicationInput, options: CallOptions) !create_application.CreateApplicationOutput {
        return create_application.execute(self, allocator, input, options);
    }

    /// Creates a new code review configuration in an agent space. A code review
    /// defines the parameters for automated security-focused code analysis.
    pub fn createCodeReview(self: *Self, allocator: std.mem.Allocator, input: create_code_review.CreateCodeReviewInput, options: CallOptions) !create_code_review.CreateCodeReviewOutput {
        return create_code_review.execute(self, allocator, input, options);
    }

    /// Creates a new integration with a third-party provider, such as GitHub, for
    /// code review and remediation.
    pub fn createIntegration(self: *Self, allocator: std.mem.Allocator, input: create_integration.CreateIntegrationInput, options: CallOptions) !create_integration.CreateIntegrationOutput {
        return create_integration.execute(self, allocator, input, options);
    }

    /// Creates a new membership, granting a user access to an agent space within an
    /// application.
    pub fn createMembership(self: *Self, allocator: std.mem.Allocator, input: create_membership.CreateMembershipInput, options: CallOptions) !create_membership.CreateMembershipOutput {
        return create_membership.execute(self, allocator, input, options);
    }

    /// Creates a new pentest configuration in an agent space. A pentest defines the
    /// security test parameters, including target assets, risk type exclusions, and
    /// logging configuration.
    pub fn createPentest(self: *Self, allocator: std.mem.Allocator, input: create_pentest.CreatePentestInput, options: CallOptions) !create_pentest.CreatePentestOutput {
        return create_pentest.execute(self, allocator, input, options);
    }

    /// Creates a private connection for reaching a self-hosted provider instance
    /// over private networking using Amazon VPC Lattice.
    pub fn createPrivateConnection(self: *Self, allocator: std.mem.Allocator, input: create_private_connection.CreatePrivateConnectionInput, options: CallOptions) !create_private_connection.CreatePrivateConnectionOutput {
        return create_private_connection.execute(self, allocator, input, options);
    }

    /// Creates a customer managed security requirement pack.
    pub fn createSecurityRequirementPack(self: *Self, allocator: std.mem.Allocator, input: create_security_requirement_pack.CreateSecurityRequirementPackInput, options: CallOptions) !create_security_requirement_pack.CreateSecurityRequirementPackOutput {
        return create_security_requirement_pack.execute(self, allocator, input, options);
    }

    /// Creates a new target domain for penetration testing. A target domain is a
    /// web domain that must be registered and verified before it can be tested.
    pub fn createTargetDomain(self: *Self, allocator: std.mem.Allocator, input: create_target_domain.CreateTargetDomainInput, options: CallOptions) !create_target_domain.CreateTargetDomainOutput {
        return create_target_domain.execute(self, allocator, input, options);
    }

    /// Creates a new threat under a threat model job.
    pub fn createThreat(self: *Self, allocator: std.mem.Allocator, input: create_threat.CreateThreatInput, options: CallOptions) !create_threat.CreateThreatOutput {
        return create_threat.execute(self, allocator, input, options);
    }

    /// Creates a new threat model configuration in an agent space. A threat model
    /// defines the parameters for automated threat analysis.
    pub fn createThreatModel(self: *Self, allocator: std.mem.Allocator, input: create_threat_model.CreateThreatModelInput, options: CallOptions) !create_threat_model.CreateThreatModelOutput {
        return create_threat_model.execute(self, allocator, input, options);
    }

    /// Deletes an agent space and all of its associated resources, including
    /// pentests, findings, and artifacts.
    pub fn deleteAgentSpace(self: *Self, allocator: std.mem.Allocator, input: delete_agent_space.DeleteAgentSpaceInput, options: CallOptions) !delete_agent_space.DeleteAgentSpaceOutput {
        return delete_agent_space.execute(self, allocator, input, options);
    }

    /// Deletes an application and its associated configuration, including IAM
    /// Identity Center settings.
    pub fn deleteApplication(self: *Self, allocator: std.mem.Allocator, input: delete_application.DeleteApplicationInput, options: CallOptions) !delete_application.DeleteApplicationOutput {
        return delete_application.execute(self, allocator, input, options);
    }

    /// Deletes an artifact from an agent space.
    pub fn deleteArtifact(self: *Self, allocator: std.mem.Allocator, input: delete_artifact.DeleteArtifactInput, options: CallOptions) !delete_artifact.DeleteArtifactOutput {
        return delete_artifact.execute(self, allocator, input, options);
    }

    /// Deletes an integration with a third-party provider.
    pub fn deleteIntegration(self: *Self, allocator: std.mem.Allocator, input: delete_integration.DeleteIntegrationInput, options: CallOptions) !delete_integration.DeleteIntegrationOutput {
        return delete_integration.execute(self, allocator, input, options);
    }

    /// Deletes a membership, revoking a user's access to an agent space.
    pub fn deleteMembership(self: *Self, allocator: std.mem.Allocator, input: delete_membership.DeleteMembershipInput, options: CallOptions) !delete_membership.DeleteMembershipOutput {
        return delete_membership.execute(self, allocator, input, options);
    }

    /// Deletes a private connection.
    pub fn deletePrivateConnection(self: *Self, allocator: std.mem.Allocator, input: delete_private_connection.DeletePrivateConnectionInput, options: CallOptions) !delete_private_connection.DeletePrivateConnectionOutput {
        return delete_private_connection.execute(self, allocator, input, options);
    }

    /// Deletes a customer managed security requirement pack and all its associated
    /// security requirements.
    pub fn deleteSecurityRequirementPack(self: *Self, allocator: std.mem.Allocator, input: delete_security_requirement_pack.DeleteSecurityRequirementPackInput, options: CallOptions) !delete_security_requirement_pack.DeleteSecurityRequirementPackOutput {
        return delete_security_requirement_pack.execute(self, allocator, input, options);
    }

    /// Deletes a target domain registration. After deletion, the domain can no
    /// longer be used for penetration testing.
    pub fn deleteTargetDomain(self: *Self, allocator: std.mem.Allocator, input: delete_target_domain.DeleteTargetDomainInput, options: CallOptions) !delete_target_domain.DeleteTargetDomainOutput {
        return delete_target_domain.execute(self, allocator, input, options);
    }

    /// Retrieves the details of a private connection.
    pub fn describePrivateConnection(self: *Self, allocator: std.mem.Allocator, input: describe_private_connection.DescribePrivateConnectionInput, options: CallOptions) !describe_private_connection.DescribePrivateConnectionOutput {
        return describe_private_connection.execute(self, allocator, input, options);
    }

    /// Retrieves information about an application.
    pub fn getApplication(self: *Self, allocator: std.mem.Allocator, input: get_application.GetApplicationInput, options: CallOptions) !get_application.GetApplicationOutput {
        return get_application.execute(self, allocator, input, options);
    }

    /// Retrieves an artifact from an agent space.
    pub fn getArtifact(self: *Self, allocator: std.mem.Allocator, input: get_artifact.GetArtifactInput, options: CallOptions) !get_artifact.GetArtifactOutput {
        return get_artifact.execute(self, allocator, input, options);
    }

    /// Retrieves information about an integration.
    pub fn getIntegration(self: *Self, allocator: std.mem.Allocator, input: get_integration.GetIntegrationInput, options: CallOptions) !get_integration.GetIntegrationOutput {
        return get_integration.execute(self, allocator, input, options);
    }

    /// Retrieves information about a security requirement pack.
    pub fn getSecurityRequirementPack(self: *Self, allocator: std.mem.Allocator, input: get_security_requirement_pack.GetSecurityRequirementPackInput, options: CallOptions) !get_security_requirement_pack.GetSecurityRequirementPackOutput {
        return get_security_requirement_pack.execute(self, allocator, input, options);
    }

    /// Imports security requirements from uploaded documents into a customer
    /// managed security requirement pack. The import process asynchronously
    /// extracts and generates structured security requirements from the provided
    /// source files.
    pub fn importSecurityRequirements(self: *Self, allocator: std.mem.Allocator, input: import_security_requirements.ImportSecurityRequirementsInput, options: CallOptions) !import_security_requirements.ImportSecurityRequirementsOutput {
        return import_security_requirements.execute(self, allocator, input, options);
    }

    /// Initiates the OAuth registration flow with a third-party provider. Returns a
    /// redirect URL and CSRF state token for completing the authorization.
    pub fn initiateProviderRegistration(self: *Self, allocator: std.mem.Allocator, input: initiate_provider_registration.InitiateProviderRegistrationInput, options: CallOptions) !initiate_provider_registration.InitiateProviderRegistrationOutput {
        return initiate_provider_registration.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of the email MFA messages received for an actor at
    /// its server-generated email address, most recent first.
    pub fn listActorMessages(self: *Self, allocator: std.mem.Allocator, input: list_actor_messages.ListActorMessagesInput, options: CallOptions) !list_actor_messages.ListActorMessagesOutput {
        return list_actor_messages.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of agent space summaries in your account.
    pub fn listAgentSpaces(self: *Self, allocator: std.mem.Allocator, input: list_agent_spaces.ListAgentSpacesInput, options: CallOptions) !list_agent_spaces.ListAgentSpacesOutput {
        return list_agent_spaces.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of application summaries in your account.
    pub fn listApplications(self: *Self, allocator: std.mem.Allocator, input: list_applications.ListApplicationsInput, options: CallOptions) !list_applications.ListApplicationsOutput {
        return list_applications.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of artifact summaries for the specified agent
    /// space.
    pub fn listArtifacts(self: *Self, allocator: std.mem.Allocator, input: list_artifacts.ListArtifactsInput, options: CallOptions) !list_artifacts.ListArtifactsOutput {
        return list_artifacts.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of task summaries for the specified code review
    /// job, optionally filtered by step name or category.
    pub fn listCodeReviewJobTasks(self: *Self, allocator: std.mem.Allocator, input: list_code_review_job_tasks.ListCodeReviewJobTasksInput, options: CallOptions) !list_code_review_job_tasks.ListCodeReviewJobTasksOutput {
        return list_code_review_job_tasks.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of code review job summaries for the specified code
    /// review configuration.
    pub fn listCodeReviewJobsForCodeReview(self: *Self, allocator: std.mem.Allocator, input: list_code_review_jobs_for_code_review.ListCodeReviewJobsForCodeReviewInput, options: CallOptions) !list_code_review_jobs_for_code_review.ListCodeReviewJobsForCodeReviewOutput {
        return list_code_review_jobs_for_code_review.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of code review summaries for the specified agent
    /// space.
    pub fn listCodeReviews(self: *Self, allocator: std.mem.Allocator, input: list_code_reviews.ListCodeReviewsInput, options: CallOptions) !list_code_reviews.ListCodeReviewsOutput {
        return list_code_reviews.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of endpoints discovered during a pentest job
    /// execution.
    pub fn listDiscoveredEndpoints(self: *Self, allocator: std.mem.Allocator, input: list_discovered_endpoints.ListDiscoveredEndpointsInput, options: CallOptions) !list_discovered_endpoints.ListDiscoveredEndpointsOutput {
        return list_discovered_endpoints.execute(self, allocator, input, options);
    }

    /// Lists the security findings for a pentest job.
    pub fn listFindings(self: *Self, allocator: std.mem.Allocator, input: list_findings.ListFindingsInput, options: CallOptions) !list_findings.ListFindingsOutput {
        return list_findings.execute(self, allocator, input, options);
    }

    /// Lists the integrated resources for an agent space, optionally filtered by
    /// integration or resource type.
    pub fn listIntegratedResources(self: *Self, allocator: std.mem.Allocator, input: list_integrated_resources.ListIntegratedResourcesInput, options: CallOptions) !list_integrated_resources.ListIntegratedResourcesOutput {
        return list_integrated_resources.execute(self, allocator, input, options);
    }

    /// Lists the integrations in your account, optionally filtered by provider or
    /// provider type.
    pub fn listIntegrations(self: *Self, allocator: std.mem.Allocator, input: list_integrations.ListIntegrationsInput, options: CallOptions) !list_integrations.ListIntegrationsOutput {
        return list_integrations.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of membership summaries for the specified agent
    /// space within an application.
    pub fn listMemberships(self: *Self, allocator: std.mem.Allocator, input: list_memberships.ListMembershipsInput, options: CallOptions) !list_memberships.ListMembershipsOutput {
        return list_memberships.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of task summaries for the specified pentest job,
    /// optionally filtered by step name or category.
    pub fn listPentestJobTasks(self: *Self, allocator: std.mem.Allocator, input: list_pentest_job_tasks.ListPentestJobTasksInput, options: CallOptions) !list_pentest_job_tasks.ListPentestJobTasksOutput {
        return list_pentest_job_tasks.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of pentest job summaries for the specified pentest
    /// configuration.
    pub fn listPentestJobsForPentest(self: *Self, allocator: std.mem.Allocator, input: list_pentest_jobs_for_pentest.ListPentestJobsForPentestInput, options: CallOptions) !list_pentest_jobs_for_pentest.ListPentestJobsForPentestOutput {
        return list_pentest_jobs_for_pentest.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of pentest summaries for the specified agent space.
    pub fn listPentests(self: *Self, allocator: std.mem.Allocator, input: list_pentests.ListPentestsInput, options: CallOptions) !list_pentests.ListPentestsOutput {
        return list_pentests.execute(self, allocator, input, options);
    }

    /// Lists the private connections in your account.
    pub fn listPrivateConnections(self: *Self, allocator: std.mem.Allocator, input: list_private_connections.ListPrivateConnectionsInput, options: CallOptions) !list_private_connections.ListPrivateConnectionsOutput {
        return list_private_connections.execute(self, allocator, input, options);
    }

    /// Lists all security requirement packs in the caller's account.
    pub fn listSecurityRequirementPacks(self: *Self, allocator: std.mem.Allocator, input: list_security_requirement_packs.ListSecurityRequirementPacksInput, options: CallOptions) !list_security_requirement_packs.ListSecurityRequirementPacksOutput {
        return list_security_requirement_packs.execute(self, allocator, input, options);
    }

    /// Lists security requirements within a pack.
    pub fn listSecurityRequirements(self: *Self, allocator: std.mem.Allocator, input: list_security_requirements.ListSecurityRequirementsInput, options: CallOptions) !list_security_requirements.ListSecurityRequirementsOutput {
        return list_security_requirements.execute(self, allocator, input, options);
    }

    /// Returns the tags associated with the specified resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of target domain summaries in your account.
    pub fn listTargetDomains(self: *Self, allocator: std.mem.Allocator, input: list_target_domains.ListTargetDomainsInput, options: CallOptions) !list_target_domains.ListTargetDomainsOutput {
        return list_target_domains.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of task summaries for the specified threat model
    /// job.
    pub fn listThreatModelJobTasks(self: *Self, allocator: std.mem.Allocator, input: list_threat_model_job_tasks.ListThreatModelJobTasksInput, options: CallOptions) !list_threat_model_job_tasks.ListThreatModelJobTasksOutput {
        return list_threat_model_job_tasks.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of threat model job summaries for the specified
    /// threat model.
    pub fn listThreatModelJobs(self: *Self, allocator: std.mem.Allocator, input: list_threat_model_jobs.ListThreatModelJobsInput, options: CallOptions) !list_threat_model_jobs.ListThreatModelJobsOutput {
        return list_threat_model_jobs.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of threat model summaries for the specified agent
    /// space.
    pub fn listThreatModels(self: *Self, allocator: std.mem.Allocator, input: list_threat_models.ListThreatModelsInput, options: CallOptions) !list_threat_models.ListThreatModelsOutput {
        return list_threat_models.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of threats for a threat model job.
    pub fn listThreats(self: *Self, allocator: std.mem.Allocator, input: list_threats.ListThreatsInput, options: CallOptions) !list_threats.ListThreatsOutput {
        return list_threats.execute(self, allocator, input, options);
    }

    /// Initiates code remediation for one or more security findings. This creates
    /// pull requests in integrated repositories to fix the identified
    /// vulnerabilities.
    pub fn startCodeRemediation(self: *Self, allocator: std.mem.Allocator, input: start_code_remediation.StartCodeRemediationInput, options: CallOptions) !start_code_remediation.StartCodeRemediationOutput {
        return start_code_remediation.execute(self, allocator, input, options);
    }

    /// Starts a new code review job for a code review configuration. The job
    /// executes the security-focused code analysis defined in the code review.
    pub fn startCodeReviewJob(self: *Self, allocator: std.mem.Allocator, input: start_code_review_job.StartCodeReviewJobInput, options: CallOptions) !start_code_review_job.StartCodeReviewJobOutput {
        return start_code_review_job.execute(self, allocator, input, options);
    }

    /// Starts a new pentest job for a pentest configuration. The job executes the
    /// security tests defined in the pentest.
    pub fn startPentestJob(self: *Self, allocator: std.mem.Allocator, input: start_pentest_job.StartPentestJobInput, options: CallOptions) !start_pentest_job.StartPentestJobOutput {
        return start_pentest_job.execute(self, allocator, input, options);
    }

    /// Starts a new threat model job for a threat model configuration.
    pub fn startThreatModelJob(self: *Self, allocator: std.mem.Allocator, input: start_threat_model_job.StartThreatModelJobInput, options: CallOptions) !start_threat_model_job.StartThreatModelJobOutput {
        return start_threat_model_job.execute(self, allocator, input, options);
    }

    /// Stops a running code review job. The job transitions to a stopping state and
    /// then to stopped after cleanup completes.
    pub fn stopCodeReviewJob(self: *Self, allocator: std.mem.Allocator, input: stop_code_review_job.StopCodeReviewJobInput, options: CallOptions) !stop_code_review_job.StopCodeReviewJobOutput {
        return stop_code_review_job.execute(self, allocator, input, options);
    }

    /// Stops a running pentest job. The job transitions to a stopping state and
    /// then to stopped after cleanup completes.
    pub fn stopPentestJob(self: *Self, allocator: std.mem.Allocator, input: stop_pentest_job.StopPentestJobInput, options: CallOptions) !stop_pentest_job.StopPentestJobOutput {
        return stop_pentest_job.execute(self, allocator, input, options);
    }

    /// Stops a running threat model job.
    pub fn stopThreatModelJob(self: *Self, allocator: std.mem.Allocator, input: stop_threat_model_job.StopThreatModelJobInput, options: CallOptions) !stop_threat_model_job.StopThreatModelJobOutput {
        return stop_threat_model_job.execute(self, allocator, input, options);
    }

    /// Adds tags to a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the configuration of an existing agent space, including its name,
    /// description, AWS resources, target domains, and code review settings.
    pub fn updateAgentSpace(self: *Self, allocator: std.mem.Allocator, input: update_agent_space.UpdateAgentSpaceInput, options: CallOptions) !update_agent_space.UpdateAgentSpaceOutput {
        return update_agent_space.execute(self, allocator, input, options);
    }

    /// Updates the configuration of an existing application, including the IAM role
    /// and default KMS key.
    pub fn updateApplication(self: *Self, allocator: std.mem.Allocator, input: update_application.UpdateApplicationInput, options: CallOptions) !update_application.UpdateApplicationOutput {
        return update_application.execute(self, allocator, input, options);
    }

    /// Updates an existing code review configuration.
    pub fn updateCodeReview(self: *Self, allocator: std.mem.Allocator, input: update_code_review.UpdateCodeReviewInput, options: CallOptions) !update_code_review.UpdateCodeReviewOutput {
        return update_code_review.execute(self, allocator, input, options);
    }

    /// Updates the status or risk level of a security finding.
    pub fn updateFinding(self: *Self, allocator: std.mem.Allocator, input: update_finding.UpdateFindingInput, options: CallOptions) !update_finding.UpdateFindingOutput {
        return update_finding.execute(self, allocator, input, options);
    }

    /// Updates the integrated resources for an agent space, including their
    /// capabilities.
    pub fn updateIntegratedResources(self: *Self, allocator: std.mem.Allocator, input: update_integrated_resources.UpdateIntegratedResourcesInput, options: CallOptions) !update_integrated_resources.UpdateIntegratedResourcesOutput {
        return update_integrated_resources.execute(self, allocator, input, options);
    }

    /// Creates an integration's webhook, or rotates the HMAC signing secret of an
    /// existing one. The secret is returned only once, in this response, and cannot
    /// be retrieved again.
    pub fn updateIntegration(self: *Self, allocator: std.mem.Allocator, input: update_integration.UpdateIntegrationInput, options: CallOptions) !update_integration.UpdateIntegrationOutput {
        return update_integration.execute(self, allocator, input, options);
    }

    /// Updates an existing pentest configuration.
    pub fn updatePentest(self: *Self, allocator: std.mem.Allocator, input: update_pentest.UpdatePentestInput, options: CallOptions) !update_pentest.UpdatePentestOutput {
        return update_pentest.execute(self, allocator, input, options);
    }

    /// Updates the certificate associated with a private connection. Certificates
    /// can be added or replaced but not removed.
    pub fn updatePrivateConnectionCertificate(self: *Self, allocator: std.mem.Allocator, input: update_private_connection_certificate.UpdatePrivateConnectionCertificateInput, options: CallOptions) !update_private_connection_certificate.UpdatePrivateConnectionCertificateOutput {
        return update_private_connection_certificate.execute(self, allocator, input, options);
    }

    /// Updates a security requirement pack. For customer managed packs, both
    /// metadata and status can be updated. For AWS managed packs, only status can
    /// be updated.
    pub fn updateSecurityRequirementPack(self: *Self, allocator: std.mem.Allocator, input: update_security_requirement_pack.UpdateSecurityRequirementPackInput, options: CallOptions) !update_security_requirement_pack.UpdateSecurityRequirementPackOutput {
        return update_security_requirement_pack.execute(self, allocator, input, options);
    }

    /// Updates the verification method for a target domain.
    pub fn updateTargetDomain(self: *Self, allocator: std.mem.Allocator, input: update_target_domain.UpdateTargetDomainInput, options: CallOptions) !update_target_domain.UpdateTargetDomainOutput {
        return update_target_domain.execute(self, allocator, input, options);
    }

    /// Updates a threat.
    pub fn updateThreat(self: *Self, allocator: std.mem.Allocator, input: update_threat.UpdateThreatInput, options: CallOptions) !update_threat.UpdateThreatOutput {
        return update_threat.execute(self, allocator, input, options);
    }

    /// Updates an existing threat model configuration.
    pub fn updateThreatModel(self: *Self, allocator: std.mem.Allocator, input: update_threat_model.UpdateThreatModelInput, options: CallOptions) !update_threat_model.UpdateThreatModelOutput {
        return update_threat_model.execute(self, allocator, input, options);
    }

    /// Initiates verification of a target domain. This checks whether the domain
    /// ownership verification token has been properly configured.
    pub fn verifyTargetDomain(self: *Self, allocator: std.mem.Allocator, input: verify_target_domain.VerifyTargetDomainInput, options: CallOptions) !verify_target_domain.VerifyTargetDomainOutput {
        return verify_target_domain.execute(self, allocator, input, options);
    }

    pub fn listActorMessagesPaginator(self: *Self, params: list_actor_messages.ListActorMessagesInput) paginator.ListActorMessagesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAgentSpacesPaginator(self: *Self, params: list_agent_spaces.ListAgentSpacesInput) paginator.ListAgentSpacesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listApplicationsPaginator(self: *Self, params: list_applications.ListApplicationsInput) paginator.ListApplicationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listArtifactsPaginator(self: *Self, params: list_artifacts.ListArtifactsInput) paginator.ListArtifactsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listCodeReviewJobTasksPaginator(self: *Self, params: list_code_review_job_tasks.ListCodeReviewJobTasksInput) paginator.ListCodeReviewJobTasksPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listCodeReviewJobsForCodeReviewPaginator(self: *Self, params: list_code_review_jobs_for_code_review.ListCodeReviewJobsForCodeReviewInput) paginator.ListCodeReviewJobsForCodeReviewPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listCodeReviewsPaginator(self: *Self, params: list_code_reviews.ListCodeReviewsInput) paginator.ListCodeReviewsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDiscoveredEndpointsPaginator(self: *Self, params: list_discovered_endpoints.ListDiscoveredEndpointsInput) paginator.ListDiscoveredEndpointsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listFindingsPaginator(self: *Self, params: list_findings.ListFindingsInput) paginator.ListFindingsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listIntegratedResourcesPaginator(self: *Self, params: list_integrated_resources.ListIntegratedResourcesInput) paginator.ListIntegratedResourcesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listIntegrationsPaginator(self: *Self, params: list_integrations.ListIntegrationsInput) paginator.ListIntegrationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listMembershipsPaginator(self: *Self, params: list_memberships.ListMembershipsInput) paginator.ListMembershipsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listPentestJobTasksPaginator(self: *Self, params: list_pentest_job_tasks.ListPentestJobTasksInput) paginator.ListPentestJobTasksPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listPentestJobsForPentestPaginator(self: *Self, params: list_pentest_jobs_for_pentest.ListPentestJobsForPentestInput) paginator.ListPentestJobsForPentestPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listPentestsPaginator(self: *Self, params: list_pentests.ListPentestsInput) paginator.ListPentestsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listPrivateConnectionsPaginator(self: *Self, params: list_private_connections.ListPrivateConnectionsInput) paginator.ListPrivateConnectionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSecurityRequirementPacksPaginator(self: *Self, params: list_security_requirement_packs.ListSecurityRequirementPacksInput) paginator.ListSecurityRequirementPacksPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSecurityRequirementsPaginator(self: *Self, params: list_security_requirements.ListSecurityRequirementsInput) paginator.ListSecurityRequirementsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTargetDomainsPaginator(self: *Self, params: list_target_domains.ListTargetDomainsInput) paginator.ListTargetDomainsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listThreatModelJobTasksPaginator(self: *Self, params: list_threat_model_job_tasks.ListThreatModelJobTasksInput) paginator.ListThreatModelJobTasksPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listThreatModelJobsPaginator(self: *Self, params: list_threat_model_jobs.ListThreatModelJobsInput) paginator.ListThreatModelJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listThreatModelsPaginator(self: *Self, params: list_threat_models.ListThreatModelsInput) paginator.ListThreatModelsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listThreatsPaginator(self: *Self, params: list_threats.ListThreatsInput) paginator.ListThreatsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
