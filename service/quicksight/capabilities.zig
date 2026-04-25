const CapabilityState = @import("capability_state.zig").CapabilityState;

/// A set of actions that correspond to Amazon Quick Sight permissions.
pub const Capabilities = struct {
    /// The ability to perform actions in external services through Action
    /// connectors. Actions allow users to interact with third-party systems.
    action: ?CapabilityState = null,

    /// The ability to add or run anomaly detection.
    add_or_run_anomaly_detection_for_analyses: ?CapabilityState = null,

    /// The ability to perform actions using Bedrock Agent connectors.
    amazon_bedrock_ars_action: ?CapabilityState = null,

    /// The ability to perform actions using Bedrock Runtime connectors.
    amazon_bedrock_fs_action: ?CapabilityState = null,

    /// The ability to perform actions using Bedrock Data Automation Runtime
    /// connectors.
    amazon_bedrock_krs_action: ?CapabilityState = null,

    /// The ability to perform actions using Amazon S3 connectors.
    amazon_s_three_action: ?CapabilityState = null,

    /// The ability to perform analysis-related actions.
    analysis: ?CapabilityState = null,

    /// The ability to review and approve sharing requests of Flows.
    approve_flow_share_requests: ?CapabilityState = null,

    /// The ability to perform actions using Asana connectors.
    asana_action: ?CapabilityState = null,

    /// The ability to perform automate-related actions.
    automate: ?CapabilityState = null,

    /// The ability to perform actions using BambooHR connectors.
    bamboo_hr_action: ?CapabilityState = null,

    /// The ability to perform actions using Box Agent connectors.
    box_agent_action: ?CapabilityState = null,

    /// The ability to Build Calculation with AI
    build_calculated_field_with_q: ?CapabilityState = null,

    /// The ability to perform actions using Canva Agent connectors.
    canva_agent_action: ?CapabilityState = null,

    /// The ability to perform chat-related actions.
    chat_agent: ?CapabilityState = null,

    /// The ability to perform actions using Comprehend connectors.
    comprehend_action: ?CapabilityState = null,

    /// The ability to perform actions using Comprehend Medical connectors.
    comprehend_medical_action: ?CapabilityState = null,

    /// The ability to perform actions using Atlassian Confluence Cloud connectors.
    confluence_action: ?CapabilityState = null,

    /// The ability to create and update Bedrock Agent actions.
    create_and_update_amazon_bedrock_ars_action: ?CapabilityState = null,

    /// The ability to create and update Bedrock Runtime actions.
    create_and_update_amazon_bedrock_fs_action: ?CapabilityState = null,

    /// The ability to create and update Bedrock Data Automation Runtime actions.
    create_and_update_amazon_bedrock_krs_action: ?CapabilityState = null,

    /// The ability to create and update Amazon S3 actions.
    create_and_update_amazon_s_three_action: ?CapabilityState = null,

    /// The ability to create and update Asana actions.
    create_and_update_asana_action: ?CapabilityState = null,

    /// The ability to create and update BambooHR actions.
    create_and_update_bamboo_hr_action: ?CapabilityState = null,

    /// The ability to create and update Box Agent actions.
    create_and_update_box_agent_action: ?CapabilityState = null,

    /// The ability to create and update Canva Agent actions.
    create_and_update_canva_agent_action: ?CapabilityState = null,

    /// The ability to create and update Comprehend actions.
    create_and_update_comprehend_action: ?CapabilityState = null,

    /// The ability to create and update Comprehend Medical actions.
    create_and_update_comprehend_medical_action: ?CapabilityState = null,

    /// The ability to create and update Atlassian Confluence Cloud actions.
    create_and_update_confluence_action: ?CapabilityState = null,

    /// The ability to create and update email reports.
    create_and_update_dashboard_email_reports: ?CapabilityState = null,

    /// The ability to create and update datasets.
    create_and_update_datasets: ?CapabilityState = null,

    /// The ability to create and update data sources.
    create_and_update_data_sources: ?CapabilityState = null,

    /// The ability to create and update FactSet actions.
    create_and_update_fact_set_action: ?CapabilityState = null,

    /// The ability to create and update REST API connection actions.
    create_and_update_generic_http_action: ?CapabilityState = null,

    /// The ability to create and update GitHub actions.
    create_and_update_github_action: ?CapabilityState = null,

    /// The ability to create and update Google Calendar actions.
    create_and_update_google_calendar_action: ?CapabilityState = null,

    /// The ability to create and update Hubspot actions.
    create_and_update_hubspot_action: ?CapabilityState = null,

    /// The ability to create and update HuggingFace actions.
    create_and_update_hugging_face_action: ?CapabilityState = null,

    /// The ability to create and update Intercom actions.
    create_and_update_intercom_action: ?CapabilityState = null,

    /// The ability to create and update Jira actions.
    create_and_update_jira_action: ?CapabilityState = null,

    /// The ability to create and update Linear actions.
    create_and_update_linear_action: ?CapabilityState = null,

    /// The ability to create and update Model Context Protocol actions.
    create_and_update_mcp_action: ?CapabilityState = null,

    /// The ability to create and update Monday actions.
    create_and_update_monday_action: ?CapabilityState = null,

    /// The ability to create and update Microsoft Outlook actions.
    create_and_update_ms_exchange_action: ?CapabilityState = null,

    /// The ability to create and update Microsoft Teams actions.
    create_and_update_ms_teams_action: ?CapabilityState = null,

    /// The ability to create and update New Relic actions.
    create_and_update_new_relic_action: ?CapabilityState = null,

    /// The ability to create and update Notion actions.
    create_and_update_notion_action: ?CapabilityState = null,

    /// The ability to create and update Microsoft OneDrive actions.
    create_and_update_one_drive_action: ?CapabilityState = null,

    /// The ability to create and update OpenAPI Specification actions.
    create_and_update_open_api_action: ?CapabilityState = null,

    /// The ability to create and update PagerDuty Advance actions.
    create_and_update_pager_duty_action: ?CapabilityState = null,

    /// The ability to create and update Salesforce actions.
    create_and_update_salesforce_action: ?CapabilityState = null,

    /// The ability to create and update S&P Global Energy actions.
    create_and_update_sand_p_global_energy_action: ?CapabilityState = null,

    /// The ability to create and update S&P Global Market Intelligence actions.
    create_and_update_sand_pgmi_action: ?CapabilityState = null,

    /// The ability to create and update SAP Bill of Materials actions.
    create_and_update_sap_bill_of_material_action: ?CapabilityState = null,

    /// The ability to create and update SAP Business Partner actions.
    create_and_update_sap_business_partner_action: ?CapabilityState = null,

    /// The ability to create and update SAP Material Stock actions.
    create_and_update_sap_material_stock_action: ?CapabilityState = null,

    /// The ability to create and update SAP Physical Inventory actions.
    create_and_update_sap_physical_inventory_action: ?CapabilityState = null,

    /// The ability to create and update SAP Product Master actions.
    create_and_update_sap_product_master_data_action: ?CapabilityState = null,

    /// The ability to create and update ServiceNow actions.
    create_and_update_service_now_action: ?CapabilityState = null,

    /// The ability to create and update Microsoft SharePoint Online actions.
    create_and_update_share_point_action: ?CapabilityState = null,

    /// The ability to create and update Slack actions.
    create_and_update_slack_action: ?CapabilityState = null,

    /// The ability to create and update Smartsheet actions.
    create_and_update_smartsheet_action: ?CapabilityState = null,

    /// The ability to create and update Textract actions.
    create_and_update_textract_action: ?CapabilityState = null,

    /// The ability to export to Create and Update themes.
    create_and_update_themes: ?CapabilityState = null,

    /// The ability to create and update threshold alerts.
    create_and_update_threshold_alerts: ?CapabilityState = null,

    /// The ability to create and update Zendesk actions.
    create_and_update_zendesk_action: ?CapabilityState = null,

    /// The ability to create chat agents.
    create_chat_agents: ?CapabilityState = null,

    /// The ability to Create Executive Summary
    create_dashboard_executive_summary_with_q: ?CapabilityState = null,

    /// The ability to create shared folders.
    create_shared_folders: ?CapabilityState = null,

    /// The ability to create spaces.
    create_spaces: ?CapabilityState = null,

    /// The ability to create a SPICE dataset.
    create_spice_dataset: ?CapabilityState = null,

    /// The ability to perform dashboard-related actions.
    dashboard: ?CapabilityState = null,

    /// The ability to Edit Visual with AI
    edit_visual_with_q: ?CapabilityState = null,

    /// The ability to export to CSV files from the UI.
    export_to_csv: ?CapabilityState = null,

    /// The ability to export to CSV files in scheduled email reports.
    export_to_csv_in_scheduled_reports: ?CapabilityState = null,

    /// The ability to export to Excel files from the UI.
    export_to_excel: ?CapabilityState = null,

    /// The ability to export to Excel files in scheduled email reports.
    export_to_excel_in_scheduled_reports: ?CapabilityState = null,

    /// The ability to export to PDF files from the UI.
    export_to_pdf: ?CapabilityState = null,

    /// The ability to export to PDF files in scheduled email reports.
    export_to_pdf_in_scheduled_reports: ?CapabilityState = null,

    /// The ability to perform Extension-related actions.
    extension: ?CapabilityState = null,

    /// The ability to perform actions using FactSet connectors.
    fact_set_action: ?CapabilityState = null,

    /// The ability to perform flow-related actions.
    flow: ?CapabilityState = null,

    /// The ability to generate analysis using AI
    generate_analyses: ?CapabilityState = null,

    /// The ability to perform actions using REST API connection connectors.
    generic_http_action: ?CapabilityState = null,

    /// The ability to perform actions using GitHub connectors.
    github_action: ?CapabilityState = null,

    /// The ability to perform actions using Google Calendar connectors.
    google_calendar_action: ?CapabilityState = null,

    /// The ability to perform actions using Hubspot connectors.
    hubspot_action: ?CapabilityState = null,

    /// The ability to perform actions using HuggingFace connectors.
    hugging_face_action: ?CapabilityState = null,

    /// The ability to include content in scheduled email reports.
    include_content_in_scheduled_reports_email: ?CapabilityState = null,

    /// The ability to perform actions using Intercom connectors.
    intercom_action: ?CapabilityState = null,

    /// The ability to perform actions using Jira connectors.
    jira_action: ?CapabilityState = null,

    /// The ability to use knowledge bases to specify content from external
    /// applications.
    knowledge_base: ?CapabilityState = null,

    /// The ability to perform actions using Linear connectors.
    linear_action: ?CapabilityState = null,

    /// The ability to create, update, delete and view shared folders (both
    /// restricted and unrestricted), ability to add any asset to shared folders,
    /// and ability to share the folders.
    ///
    /// **Note:** This does *not* prevent inheriting access to assets that others
    /// share with them through folder membership.
    manage_shared_folders: ?CapabilityState = null,

    /// The ability to perform actions using Model Context Protocol connectors.
    mcp_action: ?CapabilityState = null,

    /// The ability to perform actions using Monday connectors.
    monday_action: ?CapabilityState = null,

    /// The ability to perform actions using Microsoft Outlook connectors.
    ms_exchange_action: ?CapabilityState = null,

    /// The ability to perform actions using Microsoft Teams connectors.
    ms_teams_action: ?CapabilityState = null,

    /// The ability to perform actions using New Relic connectors.
    new_relic_action: ?CapabilityState = null,

    /// The ability to perform actions using Notion connectors.
    notion_action: ?CapabilityState = null,

    /// The ability to perform actions using Microsoft OneDrive connectors.
    one_drive_action: ?CapabilityState = null,

    /// The ability to perform actions using OpenAPI Specification connectors.
    open_api_action: ?CapabilityState = null,

    /// The ability to perform actions using PagerDuty Advance connectors.
    pager_duty_action: ?CapabilityState = null,

    /// The ability to use UI Agent step to perform tasks on public websites.
    perform_flow_ui_task: ?CapabilityState = null,

    /// The ability to print reports.
    print_reports: ?CapabilityState = null,

    /// The ability to enable approvals for flow share.
    publish_without_approval: ?CapabilityState = null,

    /// The ability to rename shared folders.
    rename_shared_folders: ?CapabilityState = null,

    /// The ability to perform research-related actions.
    research: ?CapabilityState = null,

    /// The ability to perform actions using Salesforce connectors.
    salesforce_action: ?CapabilityState = null,

    /// The ability to perform actions using S&P Global Energy connectors.
    sand_p_global_energy_action: ?CapabilityState = null,

    /// The ability to perform actions using S&P Global Market Intelligence
    /// connectors.
    sand_pgmi_action: ?CapabilityState = null,

    /// The ability to perform actions using SAP Bill of Materials connectors.
    sap_bill_of_material_action: ?CapabilityState = null,

    /// The ability to perform actions using SAP Business Partner connectors.
    sap_business_partner_action: ?CapabilityState = null,

    /// The ability to perform actions using SAP Material Stock connectors.
    sap_material_stock_action: ?CapabilityState = null,

    /// The ability to perform actions using SAP Physical Inventory connectors.
    sap_physical_inventory_action: ?CapabilityState = null,

    /// The ability to perform actions using SAP Product Master connectors.
    sap_product_master_data_action: ?CapabilityState = null,

    /// The ability to enable users to upgrade their user role.
    self_upgrade_user_role: ?CapabilityState = null,

    /// The ability to perform actions using ServiceNow connectors.
    service_now_action: ?CapabilityState = null,

    /// The ability to share Bedrock Agent actions.
    share_amazon_bedrock_ars_action: ?CapabilityState = null,

    /// The ability to share Bedrock Runtime actions.
    share_amazon_bedrock_fs_action: ?CapabilityState = null,

    /// The ability to share Bedrock Data Automation Runtime actions.
    share_amazon_bedrock_krs_action: ?CapabilityState = null,

    /// The ability to share Amazon S3 actions.
    share_amazon_s_three_action: ?CapabilityState = null,

    /// The ability to share analyses.
    share_analyses: ?CapabilityState = null,

    /// The ability to share Asana actions.
    share_asana_action: ?CapabilityState = null,

    /// The ability to share BambooHR actions.
    share_bamboo_hr_action: ?CapabilityState = null,

    /// The ability to share Box Agent actions.
    share_box_agent_action: ?CapabilityState = null,

    /// The ability to share Canva Agent actions.
    share_canva_agent_action: ?CapabilityState = null,

    /// The ability to share chat agents with other users and groups.
    share_chat_agents: ?CapabilityState = null,

    /// The ability to share Comprehend actions.
    share_comprehend_action: ?CapabilityState = null,

    /// The ability to share Comprehend Medical actions.
    share_comprehend_medical_action: ?CapabilityState = null,

    /// The ability to share Atlassian Confluence Cloud actions.
    share_confluence_action: ?CapabilityState = null,

    /// The ability to share dashboards.
    share_dashboards: ?CapabilityState = null,

    /// The ability to share datasets.
    share_datasets: ?CapabilityState = null,

    /// The ability to share data sources.
    share_data_sources: ?CapabilityState = null,

    /// The ability to share FactSet actions.
    share_fact_set_action: ?CapabilityState = null,

    /// The ability to share REST API connection actions.
    share_generic_http_action: ?CapabilityState = null,

    /// The ability to share GitHub actions.
    share_github_action: ?CapabilityState = null,

    /// The ability to share Google Calendar actions.
    share_google_calendar_action: ?CapabilityState = null,

    /// The ability to share Hubspot actions.
    share_hubspot_action: ?CapabilityState = null,

    /// The ability to share HuggingFace actions.
    share_hugging_face_action: ?CapabilityState = null,

    /// The ability to share Intercom actions.
    share_intercom_action: ?CapabilityState = null,

    /// The ability to share Jira actions.
    share_jira_action: ?CapabilityState = null,

    /// The ability to share Linear actions.
    share_linear_action: ?CapabilityState = null,

    /// The ability to share Model Context Protocol actions.
    share_mcp_action: ?CapabilityState = null,

    /// The ability to share Monday actions.
    share_monday_action: ?CapabilityState = null,

    /// The ability to share Microsoft Outlook actions.
    share_ms_exchange_action: ?CapabilityState = null,

    /// The ability to share Microsoft Teams actions.
    share_ms_teams_action: ?CapabilityState = null,

    /// The ability to share New Relic actions.
    share_new_relic_action: ?CapabilityState = null,

    /// The ability to share Notion actions.
    share_notion_action: ?CapabilityState = null,

    /// The ability to share Microsoft OneDrive actions.
    share_one_drive_action: ?CapabilityState = null,

    /// The ability to share OpenAPI Specification actions.
    share_open_api_action: ?CapabilityState = null,

    /// The ability to share PagerDuty Advance actions.
    share_pager_duty_action: ?CapabilityState = null,

    /// The ability to perform actions using Microsoft SharePoint Online connectors.
    share_point_action: ?CapabilityState = null,

    /// The ability to share Salesforce actions.
    share_salesforce_action: ?CapabilityState = null,

    /// The ability to share S&P Global Energy actions.
    share_sand_p_global_energy_action: ?CapabilityState = null,

    /// The ability to share S&P Global Market Intelligence actions.
    share_sand_pgmi_action: ?CapabilityState = null,

    /// The ability to share SAP Bill of Materials actions.
    share_sap_bill_of_material_action: ?CapabilityState = null,

    /// The ability to share SAP Business Partner actions.
    share_sap_business_partner_action: ?CapabilityState = null,

    /// The ability to share SAP Material Stock actions.
    share_sap_material_stock_action: ?CapabilityState = null,

    /// The ability to share SAP Physical Inventory actions.
    share_sap_physical_inventory_action: ?CapabilityState = null,

    /// The ability to share SAP Product Master actions.
    share_sap_product_master_data_action: ?CapabilityState = null,

    /// The ability to share ServiceNow actions.
    share_service_now_action: ?CapabilityState = null,

    /// The ability to share Microsoft SharePoint Online actions.
    share_share_point_action: ?CapabilityState = null,

    /// The ability to share Slack actions.
    share_slack_action: ?CapabilityState = null,

    /// The ability to share Smartsheet actions.
    share_smartsheet_action: ?CapabilityState = null,

    /// The ability to share spaces with other users and groups.
    share_spaces: ?CapabilityState = null,

    /// The ability to share Textract actions.
    share_textract_action: ?CapabilityState = null,

    /// The ability to share Zendesk actions.
    share_zendesk_action: ?CapabilityState = null,

    /// The ability to perform actions using Slack connectors.
    slack_action: ?CapabilityState = null,

    /// The ability to perform actions using Smartsheet connectors.
    smartsheet_action: ?CapabilityState = null,

    /// The ability to perform space-related actions.
    space: ?CapabilityState = null,

    /// The ability to subscribe to email reports.
    subscribe_dashboard_email_reports: ?CapabilityState = null,

    /// The ability to perform actions using Textract connectors.
    textract_action: ?CapabilityState = null,

    /// The ability to perform Topic-related actions.
    topic: ?CapabilityState = null,

    /// The ability to use internet to enhance results in Chat Agents, Flows, and
    /// Quick Research.
    /// Web search queries will be processed securely in an Amazon Web Services
    /// region `us-east-1`.
    use_agent_web_search: ?CapabilityState = null,

    /// The ability to use Bedrock Agent actions.
    use_amazon_bedrock_ars_action: ?CapabilityState = null,

    /// The ability to use Bedrock Runtime actions.
    use_amazon_bedrock_fs_action: ?CapabilityState = null,

    /// The ability to use Bedrock Data Automation Runtime actions.
    use_amazon_bedrock_krs_action: ?CapabilityState = null,

    /// The ability to use Amazon S3 actions.
    use_amazon_s_three_action: ?CapabilityState = null,

    /// The ability to use Asana actions.
    use_asana_action: ?CapabilityState = null,

    /// The ability to use BambooHR actions.
    use_bamboo_hr_action: ?CapabilityState = null,

    /// The ability to use Bedrock models for general knowledge step in flows.
    use_bedrock_models: ?CapabilityState = null,

    /// The ability to use Box Agent actions.
    use_box_agent_action: ?CapabilityState = null,

    /// The ability to use Canva Agent actions.
    use_canva_agent_action: ?CapabilityState = null,

    /// The ability to use Comprehend actions.
    use_comprehend_action: ?CapabilityState = null,

    /// The ability to use Comprehend Medical actions.
    use_comprehend_medical_action: ?CapabilityState = null,

    /// The ability to use Atlassian Confluence Cloud actions.
    use_confluence_action: ?CapabilityState = null,

    /// The ability to use FactSet actions.
    use_fact_set_action: ?CapabilityState = null,

    /// The ability to use REST API connection actions.
    use_generic_http_action: ?CapabilityState = null,

    /// The ability to use GitHub actions.
    use_github_action: ?CapabilityState = null,

    /// The ability to use Google Calendar actions.
    use_google_calendar_action: ?CapabilityState = null,

    /// The ability to use Hubspot actions.
    use_hubspot_action: ?CapabilityState = null,

    /// The ability to use HuggingFace actions.
    use_hugging_face_action: ?CapabilityState = null,

    /// The ability to use Intercom actions.
    use_intercom_action: ?CapabilityState = null,

    /// The ability to use Jira actions.
    use_jira_action: ?CapabilityState = null,

    /// The ability to use Linear actions.
    use_linear_action: ?CapabilityState = null,

    /// The ability to use Model Context Protocol actions.
    use_mcp_action: ?CapabilityState = null,

    /// The ability to use Monday actions.
    use_monday_action: ?CapabilityState = null,

    /// The ability to use Microsoft Outlook actions.
    use_ms_exchange_action: ?CapabilityState = null,

    /// The ability to use Microsoft Teams actions.
    use_ms_teams_action: ?CapabilityState = null,

    /// The ability to use New Relic actions.
    use_new_relic_action: ?CapabilityState = null,

    /// The ability to use Notion actions.
    use_notion_action: ?CapabilityState = null,

    /// The ability to use Microsoft OneDrive actions.
    use_one_drive_action: ?CapabilityState = null,

    /// The ability to use OpenAPI Specification actions.
    use_open_api_action: ?CapabilityState = null,

    /// The ability to use PagerDuty Advance actions.
    use_pager_duty_action: ?CapabilityState = null,

    /// The ability to use Salesforce actions.
    use_salesforce_action: ?CapabilityState = null,

    /// The ability to use S&P Global Energy actions.
    use_sand_p_global_energy_action: ?CapabilityState = null,

    /// The ability to use S&P Global Market Intelligence actions.
    use_sand_pgmi_action: ?CapabilityState = null,

    /// The ability to use SAP Bill of Materials actions.
    use_sap_bill_of_material_action: ?CapabilityState = null,

    /// The ability to use SAP Business Partner actions.
    use_sap_business_partner_action: ?CapabilityState = null,

    /// The ability to use SAP Material Stock actions.
    use_sap_material_stock_action: ?CapabilityState = null,

    /// The ability to use SAP Physical Inventory actions.
    use_sap_physical_inventory_action: ?CapabilityState = null,

    /// The ability to use SAP Product Master actions.
    use_sap_product_master_data_action: ?CapabilityState = null,

    /// The ability to use ServiceNow actions.
    use_service_now_action: ?CapabilityState = null,

    /// The ability to use Microsoft SharePoint Online actions.
    use_share_point_action: ?CapabilityState = null,

    /// The ability to use Slack actions.
    use_slack_action: ?CapabilityState = null,

    /// The ability to use Smartsheet actions.
    use_smartsheet_action: ?CapabilityState = null,

    /// The ability to use Textract actions.
    use_textract_action: ?CapabilityState = null,

    /// The ability to use Zendesk actions.
    use_zendesk_action: ?CapabilityState = null,

    /// The ability to view account SPICE capacity.
    view_account_spice_capacity: ?CapabilityState = null,

    /// The ability to perform actions using Zendesk connectors.
    zendesk_action: ?CapabilityState = null,

    pub const json_field_names = .{
        .action = "Action",
        .add_or_run_anomaly_detection_for_analyses = "AddOrRunAnomalyDetectionForAnalyses",
        .amazon_bedrock_ars_action = "AmazonBedrockARSAction",
        .amazon_bedrock_fs_action = "AmazonBedrockFSAction",
        .amazon_bedrock_krs_action = "AmazonBedrockKRSAction",
        .amazon_s_three_action = "AmazonSThreeAction",
        .analysis = "Analysis",
        .approve_flow_share_requests = "ApproveFlowShareRequests",
        .asana_action = "AsanaAction",
        .automate = "Automate",
        .bamboo_hr_action = "BambooHRAction",
        .box_agent_action = "BoxAgentAction",
        .build_calculated_field_with_q = "BuildCalculatedFieldWithQ",
        .canva_agent_action = "CanvaAgentAction",
        .chat_agent = "ChatAgent",
        .comprehend_action = "ComprehendAction",
        .comprehend_medical_action = "ComprehendMedicalAction",
        .confluence_action = "ConfluenceAction",
        .create_and_update_amazon_bedrock_ars_action = "CreateAndUpdateAmazonBedrockARSAction",
        .create_and_update_amazon_bedrock_fs_action = "CreateAndUpdateAmazonBedrockFSAction",
        .create_and_update_amazon_bedrock_krs_action = "CreateAndUpdateAmazonBedrockKRSAction",
        .create_and_update_amazon_s_three_action = "CreateAndUpdateAmazonSThreeAction",
        .create_and_update_asana_action = "CreateAndUpdateAsanaAction",
        .create_and_update_bamboo_hr_action = "CreateAndUpdateBambooHRAction",
        .create_and_update_box_agent_action = "CreateAndUpdateBoxAgentAction",
        .create_and_update_canva_agent_action = "CreateAndUpdateCanvaAgentAction",
        .create_and_update_comprehend_action = "CreateAndUpdateComprehendAction",
        .create_and_update_comprehend_medical_action = "CreateAndUpdateComprehendMedicalAction",
        .create_and_update_confluence_action = "CreateAndUpdateConfluenceAction",
        .create_and_update_dashboard_email_reports = "CreateAndUpdateDashboardEmailReports",
        .create_and_update_datasets = "CreateAndUpdateDatasets",
        .create_and_update_data_sources = "CreateAndUpdateDataSources",
        .create_and_update_fact_set_action = "CreateAndUpdateFactSetAction",
        .create_and_update_generic_http_action = "CreateAndUpdateGenericHTTPAction",
        .create_and_update_github_action = "CreateAndUpdateGithubAction",
        .create_and_update_google_calendar_action = "CreateAndUpdateGoogleCalendarAction",
        .create_and_update_hubspot_action = "CreateAndUpdateHubspotAction",
        .create_and_update_hugging_face_action = "CreateAndUpdateHuggingFaceAction",
        .create_and_update_intercom_action = "CreateAndUpdateIntercomAction",
        .create_and_update_jira_action = "CreateAndUpdateJiraAction",
        .create_and_update_linear_action = "CreateAndUpdateLinearAction",
        .create_and_update_mcp_action = "CreateAndUpdateMCPAction",
        .create_and_update_monday_action = "CreateAndUpdateMondayAction",
        .create_and_update_ms_exchange_action = "CreateAndUpdateMSExchangeAction",
        .create_and_update_ms_teams_action = "CreateAndUpdateMSTeamsAction",
        .create_and_update_new_relic_action = "CreateAndUpdateNewRelicAction",
        .create_and_update_notion_action = "CreateAndUpdateNotionAction",
        .create_and_update_one_drive_action = "CreateAndUpdateOneDriveAction",
        .create_and_update_open_api_action = "CreateAndUpdateOpenAPIAction",
        .create_and_update_pager_duty_action = "CreateAndUpdatePagerDutyAction",
        .create_and_update_salesforce_action = "CreateAndUpdateSalesforceAction",
        .create_and_update_sand_p_global_energy_action = "CreateAndUpdateSandPGlobalEnergyAction",
        .create_and_update_sand_pgmi_action = "CreateAndUpdateSandPGMIAction",
        .create_and_update_sap_bill_of_material_action = "CreateAndUpdateSAPBillOfMaterialAction",
        .create_and_update_sap_business_partner_action = "CreateAndUpdateSAPBusinessPartnerAction",
        .create_and_update_sap_material_stock_action = "CreateAndUpdateSAPMaterialStockAction",
        .create_and_update_sap_physical_inventory_action = "CreateAndUpdateSAPPhysicalInventoryAction",
        .create_and_update_sap_product_master_data_action = "CreateAndUpdateSAPProductMasterDataAction",
        .create_and_update_service_now_action = "CreateAndUpdateServiceNowAction",
        .create_and_update_share_point_action = "CreateAndUpdateSharePointAction",
        .create_and_update_slack_action = "CreateAndUpdateSlackAction",
        .create_and_update_smartsheet_action = "CreateAndUpdateSmartsheetAction",
        .create_and_update_textract_action = "CreateAndUpdateTextractAction",
        .create_and_update_themes = "CreateAndUpdateThemes",
        .create_and_update_threshold_alerts = "CreateAndUpdateThresholdAlerts",
        .create_and_update_zendesk_action = "CreateAndUpdateZendeskAction",
        .create_chat_agents = "CreateChatAgents",
        .create_dashboard_executive_summary_with_q = "CreateDashboardExecutiveSummaryWithQ",
        .create_shared_folders = "CreateSharedFolders",
        .create_spaces = "CreateSpaces",
        .create_spice_dataset = "CreateSPICEDataset",
        .dashboard = "Dashboard",
        .edit_visual_with_q = "EditVisualWithQ",
        .export_to_csv = "ExportToCsv",
        .export_to_csv_in_scheduled_reports = "ExportToCsvInScheduledReports",
        .export_to_excel = "ExportToExcel",
        .export_to_excel_in_scheduled_reports = "ExportToExcelInScheduledReports",
        .export_to_pdf = "ExportToPdf",
        .export_to_pdf_in_scheduled_reports = "ExportToPdfInScheduledReports",
        .extension = "Extension",
        .fact_set_action = "FactSetAction",
        .flow = "Flow",
        .generate_analyses = "GenerateAnalyses",
        .generic_http_action = "GenericHTTPAction",
        .github_action = "GithubAction",
        .google_calendar_action = "GoogleCalendarAction",
        .hubspot_action = "HubspotAction",
        .hugging_face_action = "HuggingFaceAction",
        .include_content_in_scheduled_reports_email = "IncludeContentInScheduledReportsEmail",
        .intercom_action = "IntercomAction",
        .jira_action = "JiraAction",
        .knowledge_base = "KnowledgeBase",
        .linear_action = "LinearAction",
        .manage_shared_folders = "ManageSharedFolders",
        .mcp_action = "MCPAction",
        .monday_action = "MondayAction",
        .ms_exchange_action = "MSExchangeAction",
        .ms_teams_action = "MSTeamsAction",
        .new_relic_action = "NewRelicAction",
        .notion_action = "NotionAction",
        .one_drive_action = "OneDriveAction",
        .open_api_action = "OpenAPIAction",
        .pager_duty_action = "PagerDutyAction",
        .perform_flow_ui_task = "PerformFlowUiTask",
        .print_reports = "PrintReports",
        .publish_without_approval = "PublishWithoutApproval",
        .rename_shared_folders = "RenameSharedFolders",
        .research = "Research",
        .salesforce_action = "SalesforceAction",
        .sand_p_global_energy_action = "SandPGlobalEnergyAction",
        .sand_pgmi_action = "SandPGMIAction",
        .sap_bill_of_material_action = "SAPBillOfMaterialAction",
        .sap_business_partner_action = "SAPBusinessPartnerAction",
        .sap_material_stock_action = "SAPMaterialStockAction",
        .sap_physical_inventory_action = "SAPPhysicalInventoryAction",
        .sap_product_master_data_action = "SAPProductMasterDataAction",
        .self_upgrade_user_role = "SelfUpgradeUserRole",
        .service_now_action = "ServiceNowAction",
        .share_amazon_bedrock_ars_action = "ShareAmazonBedrockARSAction",
        .share_amazon_bedrock_fs_action = "ShareAmazonBedrockFSAction",
        .share_amazon_bedrock_krs_action = "ShareAmazonBedrockKRSAction",
        .share_amazon_s_three_action = "ShareAmazonSThreeAction",
        .share_analyses = "ShareAnalyses",
        .share_asana_action = "ShareAsanaAction",
        .share_bamboo_hr_action = "ShareBambooHRAction",
        .share_box_agent_action = "ShareBoxAgentAction",
        .share_canva_agent_action = "ShareCanvaAgentAction",
        .share_chat_agents = "ShareChatAgents",
        .share_comprehend_action = "ShareComprehendAction",
        .share_comprehend_medical_action = "ShareComprehendMedicalAction",
        .share_confluence_action = "ShareConfluenceAction",
        .share_dashboards = "ShareDashboards",
        .share_datasets = "ShareDatasets",
        .share_data_sources = "ShareDataSources",
        .share_fact_set_action = "ShareFactSetAction",
        .share_generic_http_action = "ShareGenericHTTPAction",
        .share_github_action = "ShareGithubAction",
        .share_google_calendar_action = "ShareGoogleCalendarAction",
        .share_hubspot_action = "ShareHubspotAction",
        .share_hugging_face_action = "ShareHuggingFaceAction",
        .share_intercom_action = "ShareIntercomAction",
        .share_jira_action = "ShareJiraAction",
        .share_linear_action = "ShareLinearAction",
        .share_mcp_action = "ShareMCPAction",
        .share_monday_action = "ShareMondayAction",
        .share_ms_exchange_action = "ShareMSExchangeAction",
        .share_ms_teams_action = "ShareMSTeamsAction",
        .share_new_relic_action = "ShareNewRelicAction",
        .share_notion_action = "ShareNotionAction",
        .share_one_drive_action = "ShareOneDriveAction",
        .share_open_api_action = "ShareOpenAPIAction",
        .share_pager_duty_action = "SharePagerDutyAction",
        .share_point_action = "SharePointAction",
        .share_salesforce_action = "ShareSalesforceAction",
        .share_sand_p_global_energy_action = "ShareSandPGlobalEnergyAction",
        .share_sand_pgmi_action = "ShareSandPGMIAction",
        .share_sap_bill_of_material_action = "ShareSAPBillOfMaterialAction",
        .share_sap_business_partner_action = "ShareSAPBusinessPartnerAction",
        .share_sap_material_stock_action = "ShareSAPMaterialStockAction",
        .share_sap_physical_inventory_action = "ShareSAPPhysicalInventoryAction",
        .share_sap_product_master_data_action = "ShareSAPProductMasterDataAction",
        .share_service_now_action = "ShareServiceNowAction",
        .share_share_point_action = "ShareSharePointAction",
        .share_slack_action = "ShareSlackAction",
        .share_smartsheet_action = "ShareSmartsheetAction",
        .share_spaces = "ShareSpaces",
        .share_textract_action = "ShareTextractAction",
        .share_zendesk_action = "ShareZendeskAction",
        .slack_action = "SlackAction",
        .smartsheet_action = "SmartsheetAction",
        .space = "Space",
        .subscribe_dashboard_email_reports = "SubscribeDashboardEmailReports",
        .textract_action = "TextractAction",
        .topic = "Topic",
        .use_agent_web_search = "UseAgentWebSearch",
        .use_amazon_bedrock_ars_action = "UseAmazonBedrockARSAction",
        .use_amazon_bedrock_fs_action = "UseAmazonBedrockFSAction",
        .use_amazon_bedrock_krs_action = "UseAmazonBedrockKRSAction",
        .use_amazon_s_three_action = "UseAmazonSThreeAction",
        .use_asana_action = "UseAsanaAction",
        .use_bamboo_hr_action = "UseBambooHRAction",
        .use_bedrock_models = "UseBedrockModels",
        .use_box_agent_action = "UseBoxAgentAction",
        .use_canva_agent_action = "UseCanvaAgentAction",
        .use_comprehend_action = "UseComprehendAction",
        .use_comprehend_medical_action = "UseComprehendMedicalAction",
        .use_confluence_action = "UseConfluenceAction",
        .use_fact_set_action = "UseFactSetAction",
        .use_generic_http_action = "UseGenericHTTPAction",
        .use_github_action = "UseGithubAction",
        .use_google_calendar_action = "UseGoogleCalendarAction",
        .use_hubspot_action = "UseHubspotAction",
        .use_hugging_face_action = "UseHuggingFaceAction",
        .use_intercom_action = "UseIntercomAction",
        .use_jira_action = "UseJiraAction",
        .use_linear_action = "UseLinearAction",
        .use_mcp_action = "UseMCPAction",
        .use_monday_action = "UseMondayAction",
        .use_ms_exchange_action = "UseMSExchangeAction",
        .use_ms_teams_action = "UseMSTeamsAction",
        .use_new_relic_action = "UseNewRelicAction",
        .use_notion_action = "UseNotionAction",
        .use_one_drive_action = "UseOneDriveAction",
        .use_open_api_action = "UseOpenAPIAction",
        .use_pager_duty_action = "UsePagerDutyAction",
        .use_salesforce_action = "UseSalesforceAction",
        .use_sand_p_global_energy_action = "UseSandPGlobalEnergyAction",
        .use_sand_pgmi_action = "UseSandPGMIAction",
        .use_sap_bill_of_material_action = "UseSAPBillOfMaterialAction",
        .use_sap_business_partner_action = "UseSAPBusinessPartnerAction",
        .use_sap_material_stock_action = "UseSAPMaterialStockAction",
        .use_sap_physical_inventory_action = "UseSAPPhysicalInventoryAction",
        .use_sap_product_master_data_action = "UseSAPProductMasterDataAction",
        .use_service_now_action = "UseServiceNowAction",
        .use_share_point_action = "UseSharePointAction",
        .use_slack_action = "UseSlackAction",
        .use_smartsheet_action = "UseSmartsheetAction",
        .use_textract_action = "UseTextractAction",
        .use_zendesk_action = "UseZendeskAction",
        .view_account_spice_capacity = "ViewAccountSPICECapacity",
        .zendesk_action = "ZendeskAction",
    };
};
