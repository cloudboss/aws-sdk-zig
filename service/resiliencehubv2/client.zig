const aws = @import("aws");
const std = @import("std");

const create_assertion = @import("create_assertion.zig");
const create_input_source = @import("create_input_source.zig");
const create_policy = @import("create_policy.zig");
const create_report = @import("create_report.zig");
const create_service = @import("create_service.zig");
const create_service_function = @import("create_service_function.zig");
const create_service_function_resources = @import("create_service_function_resources.zig");
const create_system = @import("create_system.zig");
const create_test = @import("create_test.zig");
const create_user_journey = @import("create_user_journey.zig");
const delete_assertion = @import("delete_assertion.zig");
const delete_input_source = @import("delete_input_source.zig");
const delete_policy = @import("delete_policy.zig");
const delete_service = @import("delete_service.zig");
const delete_service_function = @import("delete_service_function.zig");
const delete_service_function_resources = @import("delete_service_function_resources.zig");
const delete_system = @import("delete_system.zig");
const delete_test = @import("delete_test.zig");
const delete_test_sources = @import("delete_test_sources.zig");
const delete_user_journey = @import("delete_user_journey.zig");
const get_dependency_insights = @import("get_dependency_insights.zig");
const get_failure_mode_finding = @import("get_failure_mode_finding.zig");
const get_policy = @import("get_policy.zig");
const get_service = @import("get_service.zig");
const get_system = @import("get_system.zig");
const get_test = @import("get_test.zig");
const get_test_run = @import("get_test_run.zig");
const get_test_template = @import("get_test_template.zig");
const get_user_journey = @import("get_user_journey.zig");
const import_app = @import("import_app.zig");
const import_policy = @import("import_policy.zig");
const list_assertions = @import("list_assertions.zig");
const list_dependencies = @import("list_dependencies.zig");
const list_failure_mode_assessments = @import("list_failure_mode_assessments.zig");
const list_failure_mode_findings = @import("list_failure_mode_findings.zig");
const list_input_sources = @import("list_input_sources.zig");
const list_policies = @import("list_policies.zig");
const list_policy_events = @import("list_policy_events.zig");
const list_reports = @import("list_reports.zig");
const list_resolved_test_run_target_resources = @import("list_resolved_test_run_target_resources.zig");
const list_resources = @import("list_resources.zig");
const list_service_events = @import("list_service_events.zig");
const list_service_functions = @import("list_service_functions.zig");
const list_service_topology_edges = @import("list_service_topology_edges.zig");
const list_services = @import("list_services.zig");
const list_system_events = @import("list_system_events.zig");
const list_systems = @import("list_systems.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_test_run_dependencies = @import("list_test_run_dependencies.zig");
const list_test_run_events = @import("list_test_run_events.zig");
const list_test_run_source_events = @import("list_test_run_source_events.zig");
const list_test_run_sources = @import("list_test_run_sources.zig");
const list_test_runs = @import("list_test_runs.zig");
const list_test_sources = @import("list_test_sources.zig");
const list_test_templates = @import("list_test_templates.zig");
const list_tests = @import("list_tests.zig");
const list_user_journeys = @import("list_user_journeys.zig");
const put_test_sources = @import("put_test_sources.zig");
const start_dependency_insights = @import("start_dependency_insights.zig");
const start_failure_mode_assessment = @import("start_failure_mode_assessment.zig");
const start_test_run = @import("start_test_run.zig");
const stop_test_run = @import("stop_test_run.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_assertion = @import("update_assertion.zig");
const update_dependency = @import("update_dependency.zig");
const update_failure_mode_finding = @import("update_failure_mode_finding.zig");
const update_policy = @import("update_policy.zig");
const update_service = @import("update_service.zig");
const update_service_function = @import("update_service_function.zig");
const update_system = @import("update_system.zig");
const update_test = @import("update_test.zig");
const update_user_journey = @import("update_user_journey.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    options: aws.http.RequestOptions = .{},

    const Self = @This();
    pub const sdk_id = "resiliencehubv2";

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

    /// Creates a resilience assertion for a service.
    pub fn createAssertion(self: *Self, allocator: std.mem.Allocator, input: create_assertion.CreateAssertionInput, options: CallOptions) !create_assertion.CreateAssertionOutput {
        return create_assertion.execute(self, allocator, input, options);
    }

    /// Creates an input source for a service.
    pub fn createInputSource(self: *Self, allocator: std.mem.Allocator, input: create_input_source.CreateInputSourceInput, options: CallOptions) !create_input_source.CreateInputSourceOutput {
        return create_input_source.execute(self, allocator, input, options);
    }

    /// Creates a resilience policy that defines availability and disaster recovery
    /// requirements.
    pub fn createPolicy(self: *Self, allocator: std.mem.Allocator, input: create_policy.CreatePolicyInput, options: CallOptions) !create_policy.CreatePolicyOutput {
        return create_policy.execute(self, allocator, input, options);
    }

    /// On-demand report creation. Idempotent — duplicate requests with same
    /// clientToken return existing result.
    pub fn createReport(self: *Self, allocator: std.mem.Allocator, input: create_report.CreateReportInput, options: CallOptions) !create_report.CreateReportOutput {
        return create_report.execute(self, allocator, input, options);
    }

    /// Creates a service.
    pub fn createService(self: *Self, allocator: std.mem.Allocator, input: create_service.CreateServiceInput, options: CallOptions) !create_service.CreateServiceOutput {
        return create_service.execute(self, allocator, input, options);
    }

    /// Creates a service function within a service.
    pub fn createServiceFunction(self: *Self, allocator: std.mem.Allocator, input: create_service_function.CreateServiceFunctionInput, options: CallOptions) !create_service_function.CreateServiceFunctionOutput {
        return create_service_function.execute(self, allocator, input, options);
    }

    /// Associates resources with a service function.
    pub fn createServiceFunctionResources(self: *Self, allocator: std.mem.Allocator, input: create_service_function_resources.CreateServiceFunctionResourcesInput, options: CallOptions) !create_service_function_resources.CreateServiceFunctionResourcesOutput {
        return create_service_function_resources.execute(self, allocator, input, options);
    }

    /// Creates a system that represents a logical grouping of services.
    pub fn createSystem(self: *Self, allocator: std.mem.Allocator, input: create_system.CreateSystemInput, options: CallOptions) !create_system.CreateSystemOutput {
        return create_system.execute(self, allocator, input, options);
    }

    /// Creates a test for a service by configuring a test template. Each service
    /// has one test per template.
    pub fn createTest(self: *Self, allocator: std.mem.Allocator, input: create_test.CreateTestInput, options: CallOptions) !create_test.CreateTestOutput {
        return create_test.execute(self, allocator, input, options);
    }

    /// Creates a user journey within a system.
    pub fn createUserJourney(self: *Self, allocator: std.mem.Allocator, input: create_user_journey.CreateUserJourneyInput, options: CallOptions) !create_user_journey.CreateUserJourneyOutput {
        return create_user_journey.execute(self, allocator, input, options);
    }

    /// Deletes a resilience assertion from a service.
    pub fn deleteAssertion(self: *Self, allocator: std.mem.Allocator, input: delete_assertion.DeleteAssertionInput, options: CallOptions) !delete_assertion.DeleteAssertionOutput {
        return delete_assertion.execute(self, allocator, input, options);
    }

    /// Deletes an input source.
    pub fn deleteInputSource(self: *Self, allocator: std.mem.Allocator, input: delete_input_source.DeleteInputSourceInput, options: CallOptions) !delete_input_source.DeleteInputSourceOutput {
        return delete_input_source.execute(self, allocator, input, options);
    }

    /// Deletes a resilience policy.
    pub fn deletePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_policy.DeletePolicyInput, options: CallOptions) !delete_policy.DeletePolicyOutput {
        return delete_policy.execute(self, allocator, input, options);
    }

    /// Deletes a service.
    pub fn deleteService(self: *Self, allocator: std.mem.Allocator, input: delete_service.DeleteServiceInput, options: CallOptions) !delete_service.DeleteServiceOutput {
        return delete_service.execute(self, allocator, input, options);
    }

    /// Deletes a service function.
    pub fn deleteServiceFunction(self: *Self, allocator: std.mem.Allocator, input: delete_service_function.DeleteServiceFunctionInput, options: CallOptions) !delete_service_function.DeleteServiceFunctionOutput {
        return delete_service_function.execute(self, allocator, input, options);
    }

    /// Removes resources from a service function.
    pub fn deleteServiceFunctionResources(self: *Self, allocator: std.mem.Allocator, input: delete_service_function_resources.DeleteServiceFunctionResourcesInput, options: CallOptions) !delete_service_function_resources.DeleteServiceFunctionResourcesOutput {
        return delete_service_function_resources.execute(self, allocator, input, options);
    }

    /// Deletes a system.
    pub fn deleteSystem(self: *Self, allocator: std.mem.Allocator, input: delete_system.DeleteSystemInput, options: CallOptions) !delete_system.DeleteSystemOutput {
        return delete_system.execute(self, allocator, input, options);
    }

    /// Deletes a test.
    pub fn deleteTest(self: *Self, allocator: std.mem.Allocator, input: delete_test.DeleteTestInput, options: CallOptions) !delete_test.DeleteTestOutput {
        return delete_test.execute(self, allocator, input, options);
    }

    /// Removes monitoring sources from a test. The operation is transactional and
    /// idempotent — removing a source that is not attached is a no-op.
    pub fn deleteTestSources(self: *Self, allocator: std.mem.Allocator, input: delete_test_sources.DeleteTestSourcesInput, options: CallOptions) !delete_test_sources.DeleteTestSourcesOutput {
        return delete_test_sources.execute(self, allocator, input, options);
    }

    /// Deletes a user journey.
    pub fn deleteUserJourney(self: *Self, allocator: std.mem.Allocator, input: delete_user_journey.DeleteUserJourneyInput, options: CallOptions) !delete_user_journey.DeleteUserJourneyOutput {
        return delete_user_journey.execute(self, allocator, input, options);
    }

    /// Retrieves the dependency insights generated for a service. The response
    /// reports the current generation status; insights are populated once
    /// generation has completed. If generation failed, the response includes an
    /// error code, whose possible values are listed under the response's errorCode
    /// field, and a message describing the cause. To use this operation, you must
    /// have the `resiliencehub:GetDependencyInsights` permission on the service.
    pub fn getDependencyInsights(self: *Self, allocator: std.mem.Allocator, input: get_dependency_insights.GetDependencyInsightsInput, options: CallOptions) !get_dependency_insights.GetDependencyInsightsOutput {
        return get_dependency_insights.execute(self, allocator, input, options);
    }

    /// Retrieves a finding by findingId.
    pub fn getFailureModeFinding(self: *Self, allocator: std.mem.Allocator, input: get_failure_mode_finding.GetFailureModeFindingInput, options: CallOptions) !get_failure_mode_finding.GetFailureModeFindingOutput {
        return get_failure_mode_finding.execute(self, allocator, input, options);
    }

    /// Retrieves a resilience policy by ARN.
    pub fn getPolicy(self: *Self, allocator: std.mem.Allocator, input: get_policy.GetPolicyInput, options: CallOptions) !get_policy.GetPolicyOutput {
        return get_policy.execute(self, allocator, input, options);
    }

    /// Retrieves a service by ARN.
    pub fn getService(self: *Self, allocator: std.mem.Allocator, input: get_service.GetServiceInput, options: CallOptions) !get_service.GetServiceOutput {
        return get_service.execute(self, allocator, input, options);
    }

    /// Retrieves a system by ARN.
    pub fn getSystem(self: *Self, allocator: std.mem.Allocator, input: get_system.GetSystemInput, options: CallOptions) !get_system.GetSystemOutput {
        return get_system.execute(self, allocator, input, options);
    }

    /// Retrieves a test by ID.
    pub fn getTest(self: *Self, allocator: std.mem.Allocator, input: get_test.GetTestInput, options: CallOptions) !get_test.GetTestOutput {
        return get_test.execute(self, allocator, input, options);
    }

    /// Retrieves a test run by ID, including its status, results, and the
    /// configuration snapshotted when the run started.
    pub fn getTestRun(self: *Self, allocator: std.mem.Allocator, input: get_test_run.GetTestRunInput, options: CallOptions) !get_test_run.GetTestRunOutput {
        return get_test_run.execute(self, allocator, input, options);
    }

    /// Retrieves a resilience test template by ARN, including the parameters it
    /// accepts and the fault actions it runs.
    pub fn getTestTemplate(self: *Self, allocator: std.mem.Allocator, input: get_test_template.GetTestTemplateInput, options: CallOptions) !get_test_template.GetTestTemplateOutput {
        return get_test_template.execute(self, allocator, input, options);
    }

    /// Retrieves a user journey.
    pub fn getUserJourney(self: *Self, allocator: std.mem.Allocator, input: get_user_journey.GetUserJourneyInput, options: CallOptions) !get_user_journey.GetUserJourneyOutput {
        return get_user_journey.execute(self, allocator, input, options);
    }

    /// Imports a V1 app into the V2 resource model, creating a service with the
    /// same name.
    pub fn importApp(self: *Self, allocator: std.mem.Allocator, input: import_app.ImportAppInput, options: CallOptions) !import_app.ImportAppOutput {
        return import_app.execute(self, allocator, input, options);
    }

    /// Imports a V1 policy into V2, mapping RTO/RPO values from V1 scenarios.
    pub fn importPolicy(self: *Self, allocator: std.mem.Allocator, input: import_policy.ImportPolicyInput, options: CallOptions) !import_policy.ImportPolicyOutput {
        return import_policy.execute(self, allocator, input, options);
    }

    /// Lists resilience assertions for a service.
    pub fn listAssertions(self: *Self, allocator: std.mem.Allocator, input: list_assertions.ListAssertionsInput, options: CallOptions) !list_assertions.ListAssertionsOutput {
        return list_assertions.execute(self, allocator, input, options);
    }

    /// Lists dependencies discovered for services.
    pub fn listDependencies(self: *Self, allocator: std.mem.Allocator, input: list_dependencies.ListDependenciesInput, options: CallOptions) !list_dependencies.ListDependenciesOutput {
        return list_dependencies.execute(self, allocator, input, options);
    }

    /// Lists failure mode assessments.
    pub fn listFailureModeAssessments(self: *Self, allocator: std.mem.Allocator, input: list_failure_mode_assessments.ListFailureModeAssessmentsInput, options: CallOptions) !list_failure_mode_assessments.ListFailureModeAssessmentsOutput {
        return list_failure_mode_assessments.execute(self, allocator, input, options);
    }

    /// List findings.
    pub fn listFailureModeFindings(self: *Self, allocator: std.mem.Allocator, input: list_failure_mode_findings.ListFailureModeFindingsInput, options: CallOptions) !list_failure_mode_findings.ListFailureModeFindingsOutput {
        return list_failure_mode_findings.execute(self, allocator, input, options);
    }

    /// Lists input sources for a service.
    pub fn listInputSources(self: *Self, allocator: std.mem.Allocator, input: list_input_sources.ListInputSourcesInput, options: CallOptions) !list_input_sources.ListInputSourcesOutput {
        return list_input_sources.execute(self, allocator, input, options);
    }

    /// Lists resilience policies.
    pub fn listPolicies(self: *Self, allocator: std.mem.Allocator, input: list_policies.ListPoliciesInput, options: CallOptions) !list_policies.ListPoliciesOutput {
        return list_policies.execute(self, allocator, input, options);
    }

    /// Lists events for a resilience policy, including services that started or
    /// stopped using it, changes to cross-account sharing, and deletion of the
    /// policy.
    pub fn listPolicyEvents(self: *Self, allocator: std.mem.Allocator, input: list_policy_events.ListPolicyEventsInput, options: CallOptions) !list_policy_events.ListPolicyEventsOutput {
        return list_policy_events.execute(self, allocator, input, options);
    }

    /// List reports for a service, or all reports owned by the account if
    /// serviceArn is not provided.
    pub fn listReports(self: *Self, allocator: std.mem.Allocator, input: list_reports.ListReportsInput, options: CallOptions) !list_reports.ListReportsOutput {
        return list_reports.execute(self, allocator, input, options);
    }

    /// Lists the AWS resources that AWS Fault Injection Service (AWS FIS) resolved
    /// as targets for a test run.
    pub fn listResolvedTestRunTargetResources(self: *Self, allocator: std.mem.Allocator, input: list_resolved_test_run_target_resources.ListResolvedTestRunTargetResourcesInput, options: CallOptions) !list_resolved_test_run_target_resources.ListResolvedTestRunTargetResourcesOutput {
        return list_resolved_test_run_target_resources.execute(self, allocator, input, options);
    }

    /// List resources.
    pub fn listResources(self: *Self, allocator: std.mem.Allocator, input: list_resources.ListResourcesInput, options: CallOptions) !list_resources.ListResourcesOutput {
        return list_resources.execute(self, allocator, input, options);
    }

    /// Lists events for a service.
    pub fn listServiceEvents(self: *Self, allocator: std.mem.Allocator, input: list_service_events.ListServiceEventsInput, options: CallOptions) !list_service_events.ListServiceEventsOutput {
        return list_service_events.execute(self, allocator, input, options);
    }

    /// Lists service functions for a service.
    pub fn listServiceFunctions(self: *Self, allocator: std.mem.Allocator, input: list_service_functions.ListServiceFunctionsInput, options: CallOptions) !list_service_functions.ListServiceFunctionsOutput {
        return list_service_functions.execute(self, allocator, input, options);
    }

    /// Lists topology edges for a service.
    pub fn listServiceTopologyEdges(self: *Self, allocator: std.mem.Allocator, input: list_service_topology_edges.ListServiceTopologyEdgesInput, options: CallOptions) !list_service_topology_edges.ListServiceTopologyEdgesOutput {
        return list_service_topology_edges.execute(self, allocator, input, options);
    }

    /// Lists services.
    pub fn listServices(self: *Self, allocator: std.mem.Allocator, input: list_services.ListServicesInput, options: CallOptions) !list_services.ListServicesOutput {
        return list_services.execute(self, allocator, input, options);
    }

    /// Lists events for a system.
    pub fn listSystemEvents(self: *Self, allocator: std.mem.Allocator, input: list_system_events.ListSystemEventsInput, options: CallOptions) !list_system_events.ListSystemEventsOutput {
        return list_system_events.execute(self, allocator, input, options);
    }

    /// Lists systems.
    pub fn listSystems(self: *Self, allocator: std.mem.Allocator, input: list_systems.ListSystemsInput, options: CallOptions) !list_systems.ListSystemsOutput {
        return list_systems.execute(self, allocator, input, options);
    }

    /// Lists the tags for a resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists the dependencies that a test run blocked. Each dependency reflects the
    /// discovered classification captured when the run started, so results do not
    /// change if a dependency is reclassified after the run.
    pub fn listTestRunDependencies(self: *Self, allocator: std.mem.Allocator, input: list_test_run_dependencies.ListTestRunDependenciesInput, options: CallOptions) !list_test_run_dependencies.ListTestRunDependenciesOutput {
        return list_test_run_dependencies.execute(self, allocator, input, options);
    }

    /// Lists the events in a test run's timeline.
    pub fn listTestRunEvents(self: *Self, allocator: std.mem.Allocator, input: list_test_run_events.ListTestRunEventsInput, options: CallOptions) !list_test_run_events.ListTestRunEventsOutput {
        return list_test_run_events.execute(self, allocator, input, options);
    }

    /// Lists the state-change events observed for a test run monitoring source.
    /// Events are returned for one source per call, in chronological order.
    pub fn listTestRunSourceEvents(self: *Self, allocator: std.mem.Allocator, input: list_test_run_source_events.ListTestRunSourceEventsInput, options: CallOptions) !list_test_run_source_events.ListTestRunSourceEventsOutput {
        return list_test_run_source_events.execute(self, allocator, input, options);
    }

    /// Lists the monitoring source snapshots captured for a test run, optionally
    /// filtered by type.
    pub fn listTestRunSources(self: *Self, allocator: std.mem.Allocator, input: list_test_run_sources.ListTestRunSourcesInput, options: CallOptions) !list_test_run_sources.ListTestRunSourcesOutput {
        return list_test_run_sources.execute(self, allocator, input, options);
    }

    /// Lists the runs of a test, or all test runs for a service.
    pub fn listTestRuns(self: *Self, allocator: std.mem.Allocator, input: list_test_runs.ListTestRunsInput, options: CallOptions) !list_test_runs.ListTestRunsOutput {
        return list_test_runs.execute(self, allocator, input, options);
    }

    /// Lists the monitoring sources attached to a test, optionally filtered by
    /// type.
    pub fn listTestSources(self: *Self, allocator: std.mem.Allocator, input: list_test_sources.ListTestSourcesInput, options: CallOptions) !list_test_sources.ListTestSourcesOutput {
        return list_test_sources.execute(self, allocator, input, options);
    }

    /// Lists the available resilience test templates. A test template is a
    /// pre-configured, AWS recommended test that defines which resilience
    /// capability to validate.
    pub fn listTestTemplates(self: *Self, allocator: std.mem.Allocator, input: list_test_templates.ListTestTemplatesInput, options: CallOptions) !list_test_templates.ListTestTemplatesOutput {
        return list_test_templates.execute(self, allocator, input, options);
    }

    /// Lists the tests configured for a service.
    pub fn listTests(self: *Self, allocator: std.mem.Allocator, input: list_tests.ListTestsInput, options: CallOptions) !list_tests.ListTestsOutput {
        return list_tests.execute(self, allocator, input, options);
    }

    /// Lists user journeys for a system.
    pub fn listUserJourneys(self: *Self, allocator: std.mem.Allocator, input: list_user_journeys.ListUserJourneysInput, options: CallOptions) !list_user_journeys.ListUserJourneysOutput {
        return list_user_journeys.execute(self, allocator, input, options);
    }

    /// Adds or updates the monitoring sources on a test. The operation is
    /// transactional — either every source is written or the call fails and nothing
    /// is written.
    pub fn putTestSources(self: *Self, allocator: std.mem.Allocator, input: put_test_sources.PutTestSourcesInput, options: CallOptions) !put_test_sources.PutTestSourcesOutput {
        return put_test_sources.execute(self, allocator, input, options);
    }

    /// Starts generating dependency insights for a service. Generation runs
    /// asynchronously; the response returns the initial status, and you retrieve
    /// the results with GetDependencyInsights. To use this operation, you must have
    /// the `resiliencehub:StartDependencyInsights` permission on the service.
    pub fn startDependencyInsights(self: *Self, allocator: std.mem.Allocator, input: start_dependency_insights.StartDependencyInsightsInput, options: CallOptions) !start_dependency_insights.StartDependencyInsightsOutput {
        return start_dependency_insights.execute(self, allocator, input, options);
    }

    /// Starts a failure mode assessment.
    pub fn startFailureModeAssessment(self: *Self, allocator: std.mem.Allocator, input: start_failure_mode_assessment.StartFailureModeAssessmentInput, options: CallOptions) !start_failure_mode_assessment.StartFailureModeAssessmentOutput {
        return start_failure_mode_assessment.execute(self, allocator, input, options);
    }

    /// Starts a run of a test. Each run scopes to the current resources in the
    /// service and produces a pass or fail outcome.
    pub fn startTestRun(self: *Self, allocator: std.mem.Allocator, input: start_test_run.StartTestRunInput, options: CallOptions) !start_test_run.StartTestRunOutput {
        return start_test_run.execute(self, allocator, input, options);
    }

    /// Stops an in-progress test run.
    pub fn stopTestRun(self: *Self, allocator: std.mem.Allocator, input: stop_test_run.StopTestRunInput, options: CallOptions) !stop_test_run.StopTestRunOutput {
        return stop_test_run.execute(self, allocator, input, options);
    }

    /// Adds tags to a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a resilience assertion.
    pub fn updateAssertion(self: *Self, allocator: std.mem.Allocator, input: update_assertion.UpdateAssertionInput, options: CallOptions) !update_assertion.UpdateAssertionOutput {
        return update_assertion.execute(self, allocator, input, options);
    }

    /// Updates a dependency classification.
    pub fn updateDependency(self: *Self, allocator: std.mem.Allocator, input: update_dependency.UpdateDependencyInput, options: CallOptions) !update_dependency.UpdateDependencyOutput {
        return update_dependency.execute(self, allocator, input, options);
    }

    /// Updates an existing finding.
    pub fn updateFailureModeFinding(self: *Self, allocator: std.mem.Allocator, input: update_failure_mode_finding.UpdateFailureModeFindingInput, options: CallOptions) !update_failure_mode_finding.UpdateFailureModeFindingOutput {
        return update_failure_mode_finding.execute(self, allocator, input, options);
    }

    /// Updates an existing resilience policy.
    pub fn updatePolicy(self: *Self, allocator: std.mem.Allocator, input: update_policy.UpdatePolicyInput, options: CallOptions) !update_policy.UpdatePolicyOutput {
        return update_policy.execute(self, allocator, input, options);
    }

    /// Updates an existing service.
    pub fn updateService(self: *Self, allocator: std.mem.Allocator, input: update_service.UpdateServiceInput, options: CallOptions) !update_service.UpdateServiceOutput {
        return update_service.execute(self, allocator, input, options);
    }

    /// Updates a service function.
    pub fn updateServiceFunction(self: *Self, allocator: std.mem.Allocator, input: update_service_function.UpdateServiceFunctionInput, options: CallOptions) !update_service_function.UpdateServiceFunctionOutput {
        return update_service_function.execute(self, allocator, input, options);
    }

    /// Updates an existing system.
    pub fn updateSystem(self: *Self, allocator: std.mem.Allocator, input: update_system.UpdateSystemInput, options: CallOptions) !update_system.UpdateSystemOutput {
        return update_system.execute(self, allocator, input, options);
    }

    /// Updates the configuration of an existing test.
    pub fn updateTest(self: *Self, allocator: std.mem.Allocator, input: update_test.UpdateTestInput, options: CallOptions) !update_test.UpdateTestOutput {
        return update_test.execute(self, allocator, input, options);
    }

    /// Updates an existing user journey.
    pub fn updateUserJourney(self: *Self, allocator: std.mem.Allocator, input: update_user_journey.UpdateUserJourneyInput, options: CallOptions) !update_user_journey.UpdateUserJourneyOutput {
        return update_user_journey.execute(self, allocator, input, options);
    }

    pub fn listAssertionsPaginator(self: *Self, params: list_assertions.ListAssertionsInput) paginator.ListAssertionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDependenciesPaginator(self: *Self, params: list_dependencies.ListDependenciesInput) paginator.ListDependenciesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listFailureModeAssessmentsPaginator(self: *Self, params: list_failure_mode_assessments.ListFailureModeAssessmentsInput) paginator.ListFailureModeAssessmentsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listFailureModeFindingsPaginator(self: *Self, params: list_failure_mode_findings.ListFailureModeFindingsInput) paginator.ListFailureModeFindingsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listInputSourcesPaginator(self: *Self, params: list_input_sources.ListInputSourcesInput) paginator.ListInputSourcesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listPoliciesPaginator(self: *Self, params: list_policies.ListPoliciesInput) paginator.ListPoliciesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listPolicyEventsPaginator(self: *Self, params: list_policy_events.ListPolicyEventsInput) paginator.ListPolicyEventsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listReportsPaginator(self: *Self, params: list_reports.ListReportsInput) paginator.ListReportsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listResolvedTestRunTargetResourcesPaginator(self: *Self, params: list_resolved_test_run_target_resources.ListResolvedTestRunTargetResourcesInput) paginator.ListResolvedTestRunTargetResourcesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listResourcesPaginator(self: *Self, params: list_resources.ListResourcesInput) paginator.ListResourcesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listServiceEventsPaginator(self: *Self, params: list_service_events.ListServiceEventsInput) paginator.ListServiceEventsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listServiceFunctionsPaginator(self: *Self, params: list_service_functions.ListServiceFunctionsInput) paginator.ListServiceFunctionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listServiceTopologyEdgesPaginator(self: *Self, params: list_service_topology_edges.ListServiceTopologyEdgesInput) paginator.ListServiceTopologyEdgesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listServicesPaginator(self: *Self, params: list_services.ListServicesInput) paginator.ListServicesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSystemEventsPaginator(self: *Self, params: list_system_events.ListSystemEventsInput) paginator.ListSystemEventsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSystemsPaginator(self: *Self, params: list_systems.ListSystemsInput) paginator.ListSystemsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTestRunDependenciesPaginator(self: *Self, params: list_test_run_dependencies.ListTestRunDependenciesInput) paginator.ListTestRunDependenciesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTestRunEventsPaginator(self: *Self, params: list_test_run_events.ListTestRunEventsInput) paginator.ListTestRunEventsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTestRunSourceEventsPaginator(self: *Self, params: list_test_run_source_events.ListTestRunSourceEventsInput) paginator.ListTestRunSourceEventsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTestRunSourcesPaginator(self: *Self, params: list_test_run_sources.ListTestRunSourcesInput) paginator.ListTestRunSourcesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTestRunsPaginator(self: *Self, params: list_test_runs.ListTestRunsInput) paginator.ListTestRunsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTestSourcesPaginator(self: *Self, params: list_test_sources.ListTestSourcesInput) paginator.ListTestSourcesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTestsPaginator(self: *Self, params: list_tests.ListTestsInput) paginator.ListTestsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listUserJourneysPaginator(self: *Self, params: list_user_journeys.ListUserJourneysInput) paginator.ListUserJourneysPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn waitUntilServiceAssessmentCompleted(self: *Self, params: get_service.GetServiceInput) aws.waiter.WaiterError!void {
        var w = waiters.ServiceAssessmentCompletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilServiceResourceDiscoveryCompleted(self: *Self, params: get_service.GetServiceInput) aws.waiter.WaiterError!void {
        var w = waiters.ServiceResourceDiscoveryCompletedWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
