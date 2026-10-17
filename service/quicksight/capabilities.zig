const CapabilityState = @import("capability_state.zig").CapabilityState;

/// A set of actions that correspond to Amazon Quick Sight permissions.
pub const Capabilities = struct {
    /// The ability to access the native data store for new and existing apps.
    access_apps_native_data_store: ?CapabilityState = null,

    /// The ability to perform actions in external services through Action
    /// connectors. Actions allow users to interact with third-party systems.
    action: ?CapabilityState = null,

    /// The ability to add or run anomaly detection.
    add_or_run_anomaly_detection_for_analyses: ?CapabilityState = null,

    /// The ability to perform actions using Adobe Marketing Agent connectors.
    adobe_action: ?CapabilityState = null,

    /// The ability to create, update, and share Adobe Analytics data sources.
    adobe_analytics_data_source: ?CapabilityState = null,

    /// The ability to perform actions using Airtable connectors.
    airtable_action: ?CapabilityState = null,

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

    /// The ability to perform apps-related actions.
    apps: ?CapabilityState = null,

    /// The ability to perform actions using Asana connectors.
    asana_action: ?CapabilityState = null,

    /// The ability to create, update, and share Amazon Athena data sources.
    athena_data_source: ?CapabilityState = null,

    /// The ability to create, update, and share Amazon Aurora data sources.
    aurora_data_source: ?CapabilityState = null,

    /// The ability to perform automate-related actions.
    automate: ?CapabilityState = null,

    /// The ability to perform actions using BambooHR connectors.
    bamboo_hr_action: ?CapabilityState = null,

    bedrock_managed_knowledge_base: ?CapabilityState = null,

    /// The ability to perform actions using Bee connectors.
    bee_action: ?CapabilityState = null,

    /// The ability to perform actions using Box Agent connectors.
    box_agent_action: ?CapabilityState = null,

    box_knowledge_base: ?CapabilityState = null,

    /// The ability to Build Calculation with AI
    build_calculated_field_with_q: ?CapabilityState = null,

    /// The ability to perform actions using Canva Agent connectors.
    canva_agent_action: ?CapabilityState = null,

    /// The ability to perform chat-related actions.
    chat_agent: ?CapabilityState = null,

    /// The ability to perform actions using Cisco Webex Meetings connectors.
    cisco_webex_meetings_action: ?CapabilityState = null,

    /// The ability to perform actions using Cisco Webex Video Messaging Agent
    /// connectors.
    cisco_webex_vidcast_action: ?CapabilityState = null,

    /// The ability to perform actions using Comprehend connectors.
    comprehend_action: ?CapabilityState = null,

    /// The ability to perform actions using Comprehend Medical connectors.
    comprehend_medical_action: ?CapabilityState = null,

    /// The ability to perform actions using Atlassian Confluence Cloud connectors.
    confluence_action: ?CapabilityState = null,

    confluence_knowledge_base: ?CapabilityState = null,

    /// The ability to create Adobe Analytics data sources.
    create_adobe_analytics_data_source: ?CapabilityState = null,

    /// The ability to create and update Adobe Marketing Agent actions.
    create_and_update_adobe_action: ?CapabilityState = null,

    /// The ability to create and update Airtable actions.
    create_and_update_airtable_action: ?CapabilityState = null,

    /// The ability to create and update Bedrock Agent actions.
    create_and_update_amazon_bedrock_ars_action: ?CapabilityState = null,

    /// The ability to create and update Bedrock Runtime actions.
    create_and_update_amazon_bedrock_fs_action: ?CapabilityState = null,

    /// The ability to create and update Bedrock Data Automation Runtime actions.
    create_and_update_amazon_bedrock_krs_action: ?CapabilityState = null,

    /// The ability to create and update Amazon S3 actions.
    create_and_update_amazon_s_three_action: ?CapabilityState = null,

    /// The ability to create or update apps.
    create_and_update_apps: ?CapabilityState = null,

    /// The ability to create and update Asana actions.
    create_and_update_asana_action: ?CapabilityState = null,

    /// The ability to create and update BambooHR actions.
    create_and_update_bamboo_hr_action: ?CapabilityState = null,

    create_and_update_bedrock_managed_knowledge_base: ?CapabilityState = null,

    /// The ability to create and update Bee actions.
    create_and_update_bee_action: ?CapabilityState = null,

    /// The ability to create and update Box Agent actions.
    create_and_update_box_agent_action: ?CapabilityState = null,

    create_and_update_box_knowledge_base: ?CapabilityState = null,

    /// The ability to create and update Canva Agent actions.
    create_and_update_canva_agent_action: ?CapabilityState = null,

    /// The ability to create and update Cisco Webex Meetings actions.
    create_and_update_cisco_webex_meetings_action: ?CapabilityState = null,

    /// The ability to create and update Cisco Webex Video Messaging Agent actions.
    create_and_update_cisco_webex_vidcast_action: ?CapabilityState = null,

    /// The ability to create and update Comprehend actions.
    create_and_update_comprehend_action: ?CapabilityState = null,

    /// The ability to create and update Comprehend Medical actions.
    create_and_update_comprehend_medical_action: ?CapabilityState = null,

    /// The ability to create and update Atlassian Confluence Cloud actions.
    create_and_update_confluence_action: ?CapabilityState = null,

    create_and_update_confluence_knowledge_base: ?CapabilityState = null,

    /// The ability to create and update email reports.
    create_and_update_dashboard_email_reports: ?CapabilityState = null,

    /// The ability to create and update datasets.
    create_and_update_datasets: ?CapabilityState = null,

    /// The ability to create and update data sources.
    create_and_update_data_sources: ?CapabilityState = null,

    /// The ability to create and update Dropbox actions.
    create_and_update_dropbox_action: ?CapabilityState = null,

    /// The ability to create and update Dun and Bradstreet actions.
    create_and_update_dun_and_bradstreet_action: ?CapabilityState = null,

    /// The ability to create and update FactSet actions.
    create_and_update_fact_set_action: ?CapabilityState = null,

    /// The ability to create and update Figma actions.
    create_and_update_figma_action: ?CapabilityState = null,

    /// The ability to create and update REST API connection actions.
    create_and_update_generic_http_action: ?CapabilityState = null,

    /// The ability to create and update GitHub actions.
    create_and_update_github_action: ?CapabilityState = null,

    /// The ability to create and update Gmail actions.
    create_and_update_gmail_action: ?CapabilityState = null,

    /// The ability to create and update Gong actions.
    create_and_update_gong_action: ?CapabilityState = null,

    /// The ability to create and update Google Analytics actions.
    create_and_update_google_analytics_action: ?CapabilityState = null,

    /// The ability to create and update Google Calendar actions.
    create_and_update_google_calendar_action: ?CapabilityState = null,

    /// The ability to create and update Google Chat actions.
    create_and_update_google_chat_action: ?CapabilityState = null,

    /// The ability to create and update Google Docs actions.
    create_and_update_google_docs_action: ?CapabilityState = null,

    /// The ability to create and update Google Drive actions.
    create_and_update_google_drive_action: ?CapabilityState = null,

    create_and_update_google_drive_knowledge_base: ?CapabilityState = null,

    /// The ability to create and update Google Meet actions.
    create_and_update_google_meet_action: ?CapabilityState = null,

    /// The ability to create and update Google Sheets actions.
    create_and_update_google_sheets_action: ?CapabilityState = null,

    /// The ability to create and update Google Slides actions.
    create_and_update_google_slides_action: ?CapabilityState = null,

    /// The ability to create and update HG Insights Agent actions.
    create_and_update_hg_insights_action: ?CapabilityState = null,

    /// The ability to create and update Hubspot actions.
    create_and_update_hubspot_action: ?CapabilityState = null,

    /// The ability to create and update HuggingFace actions.
    create_and_update_hugging_face_action: ?CapabilityState = null,

    create_and_update_idc_knowledge_base: ?CapabilityState = null,

    /// The ability to create and update Intercom actions.
    create_and_update_intercom_action: ?CapabilityState = null,

    /// The ability to create and update Jira actions.
    create_and_update_jira_action: ?CapabilityState = null,

    create_and_update_knowledge_bases: ?CapabilityState = null,

    /// The ability to create and update Linear actions.
    create_and_update_linear_action: ?CapabilityState = null,

    /// The ability to create and update Model Context Protocol actions.
    create_and_update_mcp_action: ?CapabilityState = null,

    /// The ability to create and update Monday actions.
    create_and_update_monday_action: ?CapabilityState = null,

    /// The ability to create and update Moody's GenAI Ready Data actions.
    create_and_update_moodys_action: ?CapabilityState = null,

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

    create_and_update_one_drive_knowledge_base: ?CapabilityState = null,

    /// The ability to create and update Microsoft OneNote actions.
    create_and_update_one_note_action: ?CapabilityState = null,

    /// The ability to create and update OpenAPI Specification actions.
    create_and_update_open_api_action: ?CapabilityState = null,

    /// The ability to create and update PagerDuty Advance actions.
    create_and_update_pager_duty_action: ?CapabilityState = null,

    /// The ability to create and update PagerDuty Agent actions.
    create_and_update_pager_duty_agent_action: ?CapabilityState = null,

    create_and_update_q_business_knowledge_base: ?CapabilityState = null,

    /// The ability to create and update QuickBooks actions.
    create_and_update_quick_books_action: ?CapabilityState = null,

    create_and_update_s3_knowledge_base: ?CapabilityState = null,

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

    create_and_update_share_point_knowledge_base: ?CapabilityState = null,

    /// The ability to create and update Shopify actions.
    create_and_update_shopify_action: ?CapabilityState = null,

    /// The ability to create and update Slack actions.
    create_and_update_slack_action: ?CapabilityState = null,

    /// The ability to create and update Smartsheet actions.
    create_and_update_smartsheet_action: ?CapabilityState = null,

    /// The ability to create and update Snowflake Cortex Agent actions.
    create_and_update_snow_flake_action: ?CapabilityState = null,

    /// The ability to create and update Textract actions.
    create_and_update_textract_action: ?CapabilityState = null,

    /// The ability to export to Create and Update themes.
    create_and_update_themes: ?CapabilityState = null,

    /// The ability to create and update threshold alerts.
    create_and_update_threshold_alerts: ?CapabilityState = null,

    /// The ability to create and update Visier Agent actions.
    create_and_update_visier_agent_action: ?CapabilityState = null,

    create_and_update_web_crawler_knowledge_base: ?CapabilityState = null,

    /// The ability to create and update WhatsApp actions.
    create_and_update_whats_app_action: ?CapabilityState = null,

    /// The ability to create and update Zapier Agent actions.
    create_and_update_zapier_action: ?CapabilityState = null,

    /// The ability to create and update Zendesk actions.
    create_and_update_zendesk_action: ?CapabilityState = null,

    /// The ability to create and update Zoom actions.
    create_and_update_zoom_action: ?CapabilityState = null,

    /// The ability to create and update ZoomInfo Agent actions.
    create_and_update_zoom_info_action: ?CapabilityState = null,

    /// The ability to create Amazon Athena data sources.
    create_athena_data_source: ?CapabilityState = null,

    /// The ability to create Amazon Aurora data sources.
    create_aurora_data_source: ?CapabilityState = null,

    /// The ability to create chat agents.
    create_chat_agents: ?CapabilityState = null,

    /// The ability to Create Executive Summary
    create_dashboard_executive_summary_with_q: ?CapabilityState = null,

    /// The ability to create Databricks data sources.
    create_databricks_data_source: ?CapabilityState = null,

    /// The ability to create Db2 data sources.
    create_db_2_data_source: ?CapabilityState = null,

    /// The ability to create Denodo data sources.
    create_denodo_data_source: ?CapabilityState = null,

    /// The ability to create Amazon DocumentDB data sources.
    create_document_db_data_source: ?CapabilityState = null,

    /// The ability to create Dremio data sources.
    create_dremio_data_source: ?CapabilityState = null,

    /// The ability to create Amazon DynamoDB data sources.
    create_dynamo_db_data_source: ?CapabilityState = null,

    /// The ability to create Exasol data sources.
    create_exasol_data_source: ?CapabilityState = null,

    /// The ability to create file data sources.
    create_file_data_source: ?CapabilityState = null,

    /// The ability to create GitHub data sources.
    create_git_hub_data_source: ?CapabilityState = null,

    /// The ability to create Google Analytics data sources.
    create_google_analytics_data_source: ?CapabilityState = null,

    /// The ability to create Google BigQuery data sources.
    create_google_big_query_data_source: ?CapabilityState = null,

    /// The ability to create Google Sheets data sources.
    create_google_sheets_data_source: ?CapabilityState = null,

    /// The ability to create Impala data sources.
    create_impala_data_source: ?CapabilityState = null,

    /// The ability to create Jira data sources.
    create_jira_data_source: ?CapabilityState = null,

    /// The ability to create MariaDB data sources.
    create_maria_db_data_source: ?CapabilityState = null,

    /// The ability to create MongoDB Atlas data sources.
    create_mongo_atlas_data_source: ?CapabilityState = null,

    /// The ability to create MongoDB data sources.
    create_mongo_db_data_source: ?CapabilityState = null,

    /// The ability to create MySQL data sources.
    create_my_sql_data_source: ?CapabilityState = null,

    /// The ability to create Amazon OpenSearch Service data sources.
    create_open_search_data_source: ?CapabilityState = null,

    /// The ability to create Oracle data sources.
    create_oracle_data_source: ?CapabilityState = null,

    /// The ability to create PayPal data sources.
    create_pay_pal_data_source: ?CapabilityState = null,

    /// The ability to create PostgreSQL data sources.
    create_postgre_sql_data_source: ?CapabilityState = null,

    /// The ability to create Presto data sources.
    create_presto_data_source: ?CapabilityState = null,

    /// The ability to create Amazon QuickSight data sources.
    create_radiant_data_source: ?CapabilityState = null,

    /// The ability to create auto-discovered Amazon RDS data sources.
    create_rds_data_source: ?CapabilityState = null,

    /// The ability to create auto-discovered Amazon Redshift data sources.
    create_redshift_auto_discovered_data_source: ?CapabilityState = null,

    /// The ability to create manually configured Amazon Redshift data sources.
    create_redshift_manual_data_source: ?CapabilityState = null,

    /// The ability to create Amazon S3 Analytics data sources.
    create_s3_analytics_data_source: ?CapabilityState = null,

    /// The ability to create Amazon S3 data sources.
    create_s3_data_source: ?CapabilityState = null,

    /// The ability to create Amazon S3 Tables data sources.
    create_s3_tables_data_source: ?CapabilityState = null,

    /// The ability to create Salesforce data sources.
    create_salesforce_data_source: ?CapabilityState = null,

    /// The ability to create SAP HANA data sources.
    create_sap_hana_data_source: ?CapabilityState = null,

    /// The ability to create ServiceNow data sources.
    create_service_now_data_source: ?CapabilityState = null,

    /// The ability to create shared folders.
    create_shared_folders: ?CapabilityState = null,

    /// The ability to create Snowflake data sources.
    create_snowflake_data_source: ?CapabilityState = null,

    /// The ability to create spaces.
    create_spaces: ?CapabilityState = null,

    /// The ability to create Spark data sources.
    create_spark_data_source: ?CapabilityState = null,

    /// The ability to create a SPICE dataset.
    create_spice_dataset: ?CapabilityState = null,

    /// The ability to create SQL Server data sources.
    create_sql_server_data_source: ?CapabilityState = null,

    /// The ability to create Square data sources.
    create_square_data_source: ?CapabilityState = null,

    /// The ability to create Starburst data sources.
    create_starburst_data_source: ?CapabilityState = null,

    /// The ability to create Teradata data sources.
    create_teradata_data_source: ?CapabilityState = null,

    /// The ability to create Amazon Timestream data sources.
    create_timestream_data_source: ?CapabilityState = null,

    /// The ability to create Trino data sources.
    create_trino_data_source: ?CapabilityState = null,

    /// The ability to create Twitter data sources.
    create_twitter_data_source: ?CapabilityState = null,

    /// The ability to perform dashboard-related actions.
    dashboard: ?CapabilityState = null,

    /// The ability to create, update, and share Databricks data sources.
    databricks_data_source: ?CapabilityState = null,

    /// The ability to create, update, and share Db2 data sources.
    db_2_data_source: ?CapabilityState = null,

    /// The ability to create, update, and share Denodo data sources.
    denodo_data_source: ?CapabilityState = null,

    /// The ability to create, update, and share Amazon DocumentDB data sources.
    document_db_data_source: ?CapabilityState = null,

    /// The ability to create, update, and share Dremio data sources.
    dremio_data_source: ?CapabilityState = null,

    /// The ability to perform actions using Dropbox connectors.
    dropbox_action: ?CapabilityState = null,

    /// The ability to perform actions using Dun and Bradstreet connectors.
    dun_and_bradstreet_action: ?CapabilityState = null,

    /// The ability to create, update, and share Amazon DynamoDB data sources.
    dynamo_db_data_source: ?CapabilityState = null,

    /// The ability to Edit Visual with AI
    edit_visual_with_q: ?CapabilityState = null,

    /// The ability to create, update, and share Exasol data sources.
    exasol_data_source: ?CapabilityState = null,

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

    /// The ability to perform actions using Figma connectors.
    figma_action: ?CapabilityState = null,

    /// The ability to create, update, and share file data sources.
    file_data_source: ?CapabilityState = null,

    /// The ability to perform flow-related actions.
    flow: ?CapabilityState = null,

    /// The ability to generate analysis using AI
    generate_analyses: ?CapabilityState = null,

    /// The ability to perform actions using REST API connection connectors.
    generic_http_action: ?CapabilityState = null,

    /// The ability to perform actions using GitHub connectors.
    github_action: ?CapabilityState = null,

    /// The ability to create, update, and share GitHub data sources.
    git_hub_data_source: ?CapabilityState = null,

    /// The ability to perform actions using Gmail connectors.
    gmail_action: ?CapabilityState = null,

    /// The ability to perform actions using Gong connectors.
    gong_action: ?CapabilityState = null,

    /// The ability to perform actions using Google Analytics connectors.
    google_analytics_action: ?CapabilityState = null,

    /// The ability to create, update, and share Google Analytics data sources.
    google_analytics_data_source: ?CapabilityState = null,

    /// The ability to create, update, and share Google BigQuery data sources.
    google_big_query_data_source: ?CapabilityState = null,

    /// The ability to perform actions using Google Calendar connectors.
    google_calendar_action: ?CapabilityState = null,

    /// The ability to perform actions using Google Chat connectors.
    google_chat_action: ?CapabilityState = null,

    /// The ability to perform actions using Google Docs connectors.
    google_docs_action: ?CapabilityState = null,

    /// The ability to perform actions using Google Drive connectors.
    google_drive_action: ?CapabilityState = null,

    google_drive_knowledge_base: ?CapabilityState = null,

    /// The ability to perform actions using Google Meet connectors.
    google_meet_action: ?CapabilityState = null,

    /// The ability to perform actions using Google Sheets connectors.
    google_sheets_action: ?CapabilityState = null,

    /// The ability to create, update, and share Google Sheets data sources.
    google_sheets_data_source: ?CapabilityState = null,

    /// The ability to perform actions using Google Slides connectors.
    google_slides_action: ?CapabilityState = null,

    /// The ability to perform actions using HG Insights Agent connectors.
    hg_insights_action: ?CapabilityState = null,

    /// The ability to perform actions using Hubspot connectors.
    hubspot_action: ?CapabilityState = null,

    /// The ability to perform actions using HuggingFace connectors.
    hugging_face_action: ?CapabilityState = null,

    idc_knowledge_base: ?CapabilityState = null,

    /// The ability to create, update, and share Impala data sources.
    impala_data_source: ?CapabilityState = null,

    /// The ability to create, view, edit, delete, and run inbound email triggers
    /// for flows and automations.
    inbound_email_trigger: ?CapabilityState = null,

    /// The ability to include content in scheduled email reports.
    include_content_in_scheduled_reports_email: ?CapabilityState = null,

    /// The ability to perform actions using Intercom connectors.
    intercom_action: ?CapabilityState = null,

    /// The ability to add and invoke AI inference in new and existing apps.
    invoke_apps_ai_inference: ?CapabilityState = null,

    /// The ability to perform actions using Jira connectors.
    jira_action: ?CapabilityState = null,

    /// The ability to create, update, and share Jira data sources.
    jira_data_source: ?CapabilityState = null,

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

    /// The ability to create, update, and share MariaDB data sources.
    maria_db_data_source: ?CapabilityState = null,

    /// The ability to perform actions using Model Context Protocol connectors.
    mcp_action: ?CapabilityState = null,

    /// The ability to perform actions using Monday connectors.
    monday_action: ?CapabilityState = null,

    /// The ability to create, update, and share MongoDB Atlas data sources.
    mongo_atlas_data_source: ?CapabilityState = null,

    /// The ability to create, update, and share MongoDB data sources.
    mongo_db_data_source: ?CapabilityState = null,

    /// The ability to perform actions using Moody's GenAI Ready Data connectors.
    moodys_action: ?CapabilityState = null,

    /// The ability to perform actions using Microsoft Outlook connectors.
    ms_exchange_action: ?CapabilityState = null,

    /// The ability to perform actions using Microsoft Teams connectors.
    ms_teams_action: ?CapabilityState = null,

    /// The ability to create, update, and share MySQL data sources.
    my_sql_data_source: ?CapabilityState = null,

    /// The ability to perform actions using New Relic connectors.
    new_relic_action: ?CapabilityState = null,

    /// The ability to perform actions using Notion connectors.
    notion_action: ?CapabilityState = null,

    /// The ability to perform actions using Microsoft OneDrive connectors.
    one_drive_action: ?CapabilityState = null,

    one_drive_knowledge_base: ?CapabilityState = null,

    /// The ability to perform actions using Microsoft OneNote connectors.
    one_note_action: ?CapabilityState = null,

    /// The ability to perform actions using OpenAPI Specification connectors.
    open_api_action: ?CapabilityState = null,

    /// The ability to create, update, and share Amazon OpenSearch Service data
    /// sources.
    open_search_data_source: ?CapabilityState = null,

    /// The ability to create, update, and share Oracle data sources.
    oracle_data_source: ?CapabilityState = null,

    /// The ability to perform actions using PagerDuty Advance connectors.
    pager_duty_action: ?CapabilityState = null,

    /// The ability to perform actions using PagerDuty Agent connectors.
    pager_duty_agent_action: ?CapabilityState = null,

    /// The ability to create, update, and share PayPal data sources.
    pay_pal_data_source: ?CapabilityState = null,

    /// The ability to use UI Agent step to perform tasks on public websites.
    perform_flow_ui_task: ?CapabilityState = null,

    /// The ability to create, update, and share PostgreSQL data sources.
    postgre_sql_data_source: ?CapabilityState = null,

    /// The ability to create, update, and share Presto data sources.
    presto_data_source: ?CapabilityState = null,

    /// The ability to print reports.
    print_reports: ?CapabilityState = null,

    /// The ability to enable approvals for flow share.
    publish_without_approval: ?CapabilityState = null,

    q_business_knowledge_base: ?CapabilityState = null,

    /// The ability to perform actions using QuickBooks connectors.
    quick_books_action: ?CapabilityState = null,

    /// The ability to create, view, edit, delete, and run Quick event triggers for
    /// flows and automations.
    quick_event_trigger: ?CapabilityState = null,

    /// The ability to create, update, and share Amazon QuickSight data sources.
    radiant_data_source: ?CapabilityState = null,

    /// The ability to create, update, and share auto-discovered Amazon RDS data
    /// sources.
    rds_data_source: ?CapabilityState = null,

    /// The ability to create, update, and share auto-discovered Amazon Redshift
    /// data sources.
    redshift_auto_discovered_data_source: ?CapabilityState = null,

    /// The ability to create, update, and share manually configured Amazon Redshift
    /// data sources.
    redshift_manual_data_source: ?CapabilityState = null,

    /// The ability to rename shared folders.
    rename_shared_folders: ?CapabilityState = null,

    /// The ability to perform research-related actions.
    research: ?CapabilityState = null,

    /// The ability to create, update, and share Amazon S3 Analytics data sources.
    s3_analytics_data_source: ?CapabilityState = null,

    /// The ability to create, update, and share Amazon S3 data sources.
    s3_data_source: ?CapabilityState = null,

    s3_knowledge_base: ?CapabilityState = null,

    /// The ability to create, update, and share Amazon S3 Tables data sources.
    s3_tables_data_source: ?CapabilityState = null,

    /// The ability to perform actions using Salesforce connectors.
    salesforce_action: ?CapabilityState = null,

    /// The ability to create, update, and share Salesforce data sources.
    salesforce_data_source: ?CapabilityState = null,

    /// The ability to perform actions using S&P Global Energy connectors.
    sand_p_global_energy_action: ?CapabilityState = null,

    /// The ability to perform actions using S&P Global Market Intelligence
    /// connectors.
    sand_pgmi_action: ?CapabilityState = null,

    /// The ability to perform actions using SAP Bill of Materials connectors.
    sap_bill_of_material_action: ?CapabilityState = null,

    /// The ability to perform actions using SAP Business Partner connectors.
    sap_business_partner_action: ?CapabilityState = null,

    /// The ability to create, update, and share SAP HANA data sources.
    sap_hana_data_source: ?CapabilityState = null,

    /// The ability to perform actions using SAP Material Stock connectors.
    sap_material_stock_action: ?CapabilityState = null,

    /// The ability to perform actions using SAP Physical Inventory connectors.
    sap_physical_inventory_action: ?CapabilityState = null,

    /// The ability to perform actions using SAP Product Master connectors.
    sap_product_master_data_action: ?CapabilityState = null,

    /// The ability to perform Scenario-related actions.
    scenario: ?CapabilityState = null,

    /// The ability to create, view, edit, delete, and run schedule triggers for
    /// flows and automations.
    schedule_trigger: ?CapabilityState = null,

    /// The ability to enable users to upgrade their user role.
    self_upgrade_user_role: ?CapabilityState = null,

    /// The ability to perform actions using ServiceNow connectors.
    service_now_action: ?CapabilityState = null,

    /// The ability to create, update, and share ServiceNow data sources.
    service_now_data_source: ?CapabilityState = null,

    /// The ability to share Adobe Marketing Agent actions.
    share_adobe_action: ?CapabilityState = null,

    /// The ability to share Adobe Analytics data sources.
    share_adobe_analytics_data_source: ?CapabilityState = null,

    /// The ability to share Airtable actions.
    share_airtable_action: ?CapabilityState = null,

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

    /// The ability to share apps with other users.
    share_apps: ?CapabilityState = null,

    /// The ability to share Asana actions.
    share_asana_action: ?CapabilityState = null,

    /// The ability to share Amazon Athena data sources.
    share_athena_data_source: ?CapabilityState = null,

    /// The ability to share Amazon Aurora data sources.
    share_aurora_data_source: ?CapabilityState = null,

    /// The ability to share BambooHR actions.
    share_bamboo_hr_action: ?CapabilityState = null,

    share_bedrock_managed_knowledge_base: ?CapabilityState = null,

    /// The ability to share Bee actions.
    share_bee_action: ?CapabilityState = null,

    /// The ability to share Box Agent actions.
    share_box_agent_action: ?CapabilityState = null,

    share_box_knowledge_base: ?CapabilityState = null,

    /// The ability to share Canva Agent actions.
    share_canva_agent_action: ?CapabilityState = null,

    /// The ability to share chat agents with other users and groups.
    share_chat_agents: ?CapabilityState = null,

    /// The ability to share Cisco Webex Meetings actions.
    share_cisco_webex_meetings_action: ?CapabilityState = null,

    /// The ability to share Cisco Webex Video Messaging Agent actions.
    share_cisco_webex_vidcast_action: ?CapabilityState = null,

    /// The ability to share Comprehend actions.
    share_comprehend_action: ?CapabilityState = null,

    /// The ability to share Comprehend Medical actions.
    share_comprehend_medical_action: ?CapabilityState = null,

    /// The ability to share Atlassian Confluence Cloud actions.
    share_confluence_action: ?CapabilityState = null,

    share_confluence_knowledge_base: ?CapabilityState = null,

    /// The ability to share dashboards.
    share_dashboards: ?CapabilityState = null,

    /// The ability to share Databricks data sources.
    share_databricks_data_source: ?CapabilityState = null,

    /// The ability to share datasets.
    share_datasets: ?CapabilityState = null,

    /// The ability to share data sources.
    share_data_sources: ?CapabilityState = null,

    /// The ability to share Db2 data sources.
    share_db_2_data_source: ?CapabilityState = null,

    /// The ability to share Denodo data sources.
    share_denodo_data_source: ?CapabilityState = null,

    /// The ability to share Amazon DocumentDB data sources.
    share_document_db_data_source: ?CapabilityState = null,

    /// The ability to share Dremio data sources.
    share_dremio_data_source: ?CapabilityState = null,

    /// The ability to share Dropbox actions.
    share_dropbox_action: ?CapabilityState = null,

    /// The ability to share Dun and Bradstreet actions.
    share_dun_and_bradstreet_action: ?CapabilityState = null,

    /// The ability to share Amazon DynamoDB data sources.
    share_dynamo_db_data_source: ?CapabilityState = null,

    /// The ability to share Exasol data sources.
    share_exasol_data_source: ?CapabilityState = null,

    /// The ability to share FactSet actions.
    share_fact_set_action: ?CapabilityState = null,

    /// The ability to share Figma actions.
    share_figma_action: ?CapabilityState = null,

    /// The ability to share file data sources.
    share_file_data_source: ?CapabilityState = null,

    /// The ability to share REST API connection actions.
    share_generic_http_action: ?CapabilityState = null,

    /// The ability to share GitHub actions.
    share_github_action: ?CapabilityState = null,

    /// The ability to share GitHub data sources.
    share_git_hub_data_source: ?CapabilityState = null,

    /// The ability to share Gmail actions.
    share_gmail_action: ?CapabilityState = null,

    /// The ability to share Gong actions.
    share_gong_action: ?CapabilityState = null,

    /// The ability to share Google Analytics actions.
    share_google_analytics_action: ?CapabilityState = null,

    /// The ability to share Google Analytics data sources.
    share_google_analytics_data_source: ?CapabilityState = null,

    /// The ability to share Google BigQuery data sources.
    share_google_big_query_data_source: ?CapabilityState = null,

    /// The ability to share Google Calendar actions.
    share_google_calendar_action: ?CapabilityState = null,

    /// The ability to share Google Chat actions.
    share_google_chat_action: ?CapabilityState = null,

    /// The ability to share Google Docs actions.
    share_google_docs_action: ?CapabilityState = null,

    /// The ability to share Google Drive actions.
    share_google_drive_action: ?CapabilityState = null,

    share_google_drive_knowledge_base: ?CapabilityState = null,

    /// The ability to share Google Meet actions.
    share_google_meet_action: ?CapabilityState = null,

    /// The ability to share Google Sheets actions.
    share_google_sheets_action: ?CapabilityState = null,

    /// The ability to share Google Sheets data sources.
    share_google_sheets_data_source: ?CapabilityState = null,

    /// The ability to share Google Slides actions.
    share_google_slides_action: ?CapabilityState = null,

    /// The ability to share HG Insights Agent actions.
    share_hg_insights_action: ?CapabilityState = null,

    /// The ability to share Hubspot actions.
    share_hubspot_action: ?CapabilityState = null,

    /// The ability to share HuggingFace actions.
    share_hugging_face_action: ?CapabilityState = null,

    share_idc_knowledge_base: ?CapabilityState = null,

    /// The ability to share Impala data sources.
    share_impala_data_source: ?CapabilityState = null,

    /// The ability to share Intercom actions.
    share_intercom_action: ?CapabilityState = null,

    /// The ability to share Jira actions.
    share_jira_action: ?CapabilityState = null,

    /// The ability to share Jira data sources.
    share_jira_data_source: ?CapabilityState = null,

    share_knowledge_bases: ?CapabilityState = null,

    /// The ability to share Linear actions.
    share_linear_action: ?CapabilityState = null,

    /// The ability to share MariaDB data sources.
    share_maria_db_data_source: ?CapabilityState = null,

    /// The ability to share Model Context Protocol actions.
    share_mcp_action: ?CapabilityState = null,

    /// The ability to share Monday actions.
    share_monday_action: ?CapabilityState = null,

    /// The ability to share MongoDB Atlas data sources.
    share_mongo_atlas_data_source: ?CapabilityState = null,

    /// The ability to share MongoDB data sources.
    share_mongo_db_data_source: ?CapabilityState = null,

    /// The ability to share Moody's GenAI Ready Data actions.
    share_moodys_action: ?CapabilityState = null,

    /// The ability to share Microsoft Outlook actions.
    share_ms_exchange_action: ?CapabilityState = null,

    /// The ability to share Microsoft Teams actions.
    share_ms_teams_action: ?CapabilityState = null,

    /// The ability to share MySQL data sources.
    share_my_sql_data_source: ?CapabilityState = null,

    /// The ability to share New Relic actions.
    share_new_relic_action: ?CapabilityState = null,

    /// The ability to share Notion actions.
    share_notion_action: ?CapabilityState = null,

    /// The ability to share Microsoft OneDrive actions.
    share_one_drive_action: ?CapabilityState = null,

    share_one_drive_knowledge_base: ?CapabilityState = null,

    /// The ability to share Microsoft OneNote actions.
    share_one_note_action: ?CapabilityState = null,

    /// The ability to share OpenAPI Specification actions.
    share_open_api_action: ?CapabilityState = null,

    /// The ability to share Amazon OpenSearch Service data sources.
    share_open_search_data_source: ?CapabilityState = null,

    /// The ability to share Oracle data sources.
    share_oracle_data_source: ?CapabilityState = null,

    /// The ability to share PagerDuty Advance actions.
    share_pager_duty_action: ?CapabilityState = null,

    /// The ability to share PagerDuty Agent actions.
    share_pager_duty_agent_action: ?CapabilityState = null,

    /// The ability to share PayPal data sources.
    share_pay_pal_data_source: ?CapabilityState = null,

    /// The ability to perform actions using Microsoft SharePoint Online connectors.
    share_point_action: ?CapabilityState = null,

    share_point_knowledge_base: ?CapabilityState = null,

    /// The ability to share PostgreSQL data sources.
    share_postgre_sql_data_source: ?CapabilityState = null,

    /// The ability to share Presto data sources.
    share_presto_data_source: ?CapabilityState = null,

    share_q_business_knowledge_base: ?CapabilityState = null,

    /// The ability to share QuickBooks actions.
    share_quick_books_action: ?CapabilityState = null,

    /// The ability to share Amazon QuickSight data sources.
    share_radiant_data_source: ?CapabilityState = null,

    /// The ability to share auto-discovered Amazon RDS data sources.
    share_rds_data_source: ?CapabilityState = null,

    /// The ability to share auto-discovered Amazon Redshift data sources.
    share_redshift_auto_discovered_data_source: ?CapabilityState = null,

    /// The ability to share manually configured Amazon Redshift data sources.
    share_redshift_manual_data_source: ?CapabilityState = null,

    /// The ability to share Amazon S3 Analytics data sources.
    share_s3_analytics_data_source: ?CapabilityState = null,

    /// The ability to share Amazon S3 data sources.
    share_s3_data_source: ?CapabilityState = null,

    share_s3_knowledge_base: ?CapabilityState = null,

    /// The ability to share Amazon S3 Tables data sources.
    share_s3_tables_data_source: ?CapabilityState = null,

    /// The ability to share Salesforce actions.
    share_salesforce_action: ?CapabilityState = null,

    /// The ability to share Salesforce data sources.
    share_salesforce_data_source: ?CapabilityState = null,

    /// The ability to share S&P Global Energy actions.
    share_sand_p_global_energy_action: ?CapabilityState = null,

    /// The ability to share S&P Global Market Intelligence actions.
    share_sand_pgmi_action: ?CapabilityState = null,

    /// The ability to share SAP Bill of Materials actions.
    share_sap_bill_of_material_action: ?CapabilityState = null,

    /// The ability to share SAP Business Partner actions.
    share_sap_business_partner_action: ?CapabilityState = null,

    /// The ability to share SAP HANA data sources.
    share_sap_hana_data_source: ?CapabilityState = null,

    /// The ability to share SAP Material Stock actions.
    share_sap_material_stock_action: ?CapabilityState = null,

    /// The ability to share SAP Physical Inventory actions.
    share_sap_physical_inventory_action: ?CapabilityState = null,

    /// The ability to share SAP Product Master actions.
    share_sap_product_master_data_action: ?CapabilityState = null,

    /// The ability to share ServiceNow actions.
    share_service_now_action: ?CapabilityState = null,

    /// The ability to share ServiceNow data sources.
    share_service_now_data_source: ?CapabilityState = null,

    /// The ability to share Microsoft SharePoint Online actions.
    share_share_point_action: ?CapabilityState = null,

    share_share_point_knowledge_base: ?CapabilityState = null,

    /// The ability to share Shopify actions.
    share_shopify_action: ?CapabilityState = null,

    /// The ability to share Slack actions.
    share_slack_action: ?CapabilityState = null,

    /// The ability to share Smartsheet actions.
    share_smartsheet_action: ?CapabilityState = null,

    /// The ability to share Snowflake Cortex Agent actions.
    share_snow_flake_action: ?CapabilityState = null,

    /// The ability to share Snowflake data sources.
    share_snowflake_data_source: ?CapabilityState = null,

    /// The ability to share spaces with other users and groups.
    share_spaces: ?CapabilityState = null,

    /// The ability to share Spark data sources.
    share_spark_data_source: ?CapabilityState = null,

    /// The ability to share SQL Server data sources.
    share_sql_server_data_source: ?CapabilityState = null,

    /// The ability to share Square data sources.
    share_square_data_source: ?CapabilityState = null,

    /// The ability to share Starburst data sources.
    share_starburst_data_source: ?CapabilityState = null,

    /// The ability to share Teradata data sources.
    share_teradata_data_source: ?CapabilityState = null,

    /// The ability to share Textract actions.
    share_textract_action: ?CapabilityState = null,

    /// The ability to share Amazon Timestream data sources.
    share_timestream_data_source: ?CapabilityState = null,

    /// The ability to share Trino data sources.
    share_trino_data_source: ?CapabilityState = null,

    /// The ability to share Twitter data sources.
    share_twitter_data_source: ?CapabilityState = null,

    /// The ability to share Visier Agent actions.
    share_visier_agent_action: ?CapabilityState = null,

    share_web_crawler_knowledge_base: ?CapabilityState = null,

    /// The ability to share WhatsApp actions.
    share_whats_app_action: ?CapabilityState = null,

    /// The ability to share Zapier Agent actions.
    share_zapier_action: ?CapabilityState = null,

    /// The ability to share Zendesk actions.
    share_zendesk_action: ?CapabilityState = null,

    /// The ability to share Zoom actions.
    share_zoom_action: ?CapabilityState = null,

    /// The ability to share ZoomInfo Agent actions.
    share_zoom_info_action: ?CapabilityState = null,

    /// The ability to perform actions using Shopify connectors.
    shopify_action: ?CapabilityState = null,

    /// The ability to perform actions using Slack connectors.
    slack_action: ?CapabilityState = null,

    /// The ability to perform actions using Smartsheet connectors.
    smartsheet_action: ?CapabilityState = null,

    /// The ability to perform actions using Snowflake Cortex Agent connectors.
    snow_flake_action: ?CapabilityState = null,

    /// The ability to create, update, and share Snowflake data sources.
    snowflake_data_source: ?CapabilityState = null,

    /// The ability to perform space-related actions.
    space: ?CapabilityState = null,

    /// The ability to create, update, and share Spark data sources.
    spark_data_source: ?CapabilityState = null,

    /// The ability to create, update, and share SQL Server data sources.
    sql_server_data_source: ?CapabilityState = null,

    /// The ability to create, update, and share Square data sources.
    square_data_source: ?CapabilityState = null,

    /// The ability to create, update, and share Starburst data sources.
    starburst_data_source: ?CapabilityState = null,

    /// The ability to perform Story-related actions.
    story: ?CapabilityState = null,

    /// The ability to subscribe to email reports.
    subscribe_dashboard_email_reports: ?CapabilityState = null,

    /// The ability to create, update, and share Teradata data sources.
    teradata_data_source: ?CapabilityState = null,

    /// The ability to perform actions using Textract connectors.
    textract_action: ?CapabilityState = null,

    /// The ability to create, update, and share Amazon Timestream data sources.
    timestream_data_source: ?CapabilityState = null,

    /// The ability to perform Topic-related actions.
    topic: ?CapabilityState = null,

    /// The ability to manage trigger-related settings for flows and automations.
    trigger: ?CapabilityState = null,

    /// The ability to create, update, and share Trino data sources.
    trino_data_source: ?CapabilityState = null,

    /// The ability to create, update, and share Twitter data sources.
    twitter_data_source: ?CapabilityState = null,

    /// The ability to update Adobe Analytics data sources.
    update_adobe_analytics_data_source: ?CapabilityState = null,

    /// The ability to update Amazon Athena data sources.
    update_athena_data_source: ?CapabilityState = null,

    /// The ability to update Amazon Aurora data sources.
    update_aurora_data_source: ?CapabilityState = null,

    /// The ability to update Databricks data sources.
    update_databricks_data_source: ?CapabilityState = null,

    /// The ability to update Db2 data sources.
    update_db_2_data_source: ?CapabilityState = null,

    /// The ability to update Denodo data sources.
    update_denodo_data_source: ?CapabilityState = null,

    /// The ability to update Amazon DocumentDB data sources.
    update_document_db_data_source: ?CapabilityState = null,

    /// The ability to update Dremio data sources.
    update_dremio_data_source: ?CapabilityState = null,

    /// The ability to update Amazon DynamoDB data sources.
    update_dynamo_db_data_source: ?CapabilityState = null,

    /// The ability to update Exasol data sources.
    update_exasol_data_source: ?CapabilityState = null,

    /// The ability to update file data sources.
    update_file_data_source: ?CapabilityState = null,

    /// The ability to update GitHub data sources.
    update_git_hub_data_source: ?CapabilityState = null,

    /// The ability to update Google Analytics data sources.
    update_google_analytics_data_source: ?CapabilityState = null,

    /// The ability to update Google BigQuery data sources.
    update_google_big_query_data_source: ?CapabilityState = null,

    /// The ability to update Google Sheets data sources.
    update_google_sheets_data_source: ?CapabilityState = null,

    /// The ability to update Impala data sources.
    update_impala_data_source: ?CapabilityState = null,

    /// The ability to update Jira data sources.
    update_jira_data_source: ?CapabilityState = null,

    /// The ability to update MariaDB data sources.
    update_maria_db_data_source: ?CapabilityState = null,

    /// The ability to update MongoDB Atlas data sources.
    update_mongo_atlas_data_source: ?CapabilityState = null,

    /// The ability to update MongoDB data sources.
    update_mongo_db_data_source: ?CapabilityState = null,

    /// The ability to update MySQL data sources.
    update_my_sql_data_source: ?CapabilityState = null,

    /// The ability to update Amazon OpenSearch Service data sources.
    update_open_search_data_source: ?CapabilityState = null,

    /// The ability to update Oracle data sources.
    update_oracle_data_source: ?CapabilityState = null,

    /// The ability to update PayPal data sources.
    update_pay_pal_data_source: ?CapabilityState = null,

    /// The ability to update PostgreSQL data sources.
    update_postgre_sql_data_source: ?CapabilityState = null,

    /// The ability to update Presto data sources.
    update_presto_data_source: ?CapabilityState = null,

    /// The ability to update Amazon QuickSight data sources.
    update_radiant_data_source: ?CapabilityState = null,

    /// The ability to update auto-discovered Amazon RDS data sources.
    update_rds_data_source: ?CapabilityState = null,

    /// The ability to update auto-discovered Amazon Redshift data sources.
    update_redshift_auto_discovered_data_source: ?CapabilityState = null,

    /// The ability to update manually configured Amazon Redshift data sources.
    update_redshift_manual_data_source: ?CapabilityState = null,

    /// The ability to update Amazon S3 Analytics data sources.
    update_s3_analytics_data_source: ?CapabilityState = null,

    /// The ability to update Amazon S3 data sources.
    update_s3_data_source: ?CapabilityState = null,

    /// The ability to update Amazon S3 Tables data sources.
    update_s3_tables_data_source: ?CapabilityState = null,

    /// The ability to update Salesforce data sources.
    update_salesforce_data_source: ?CapabilityState = null,

    /// The ability to update SAP HANA data sources.
    update_sap_hana_data_source: ?CapabilityState = null,

    /// The ability to update ServiceNow data sources.
    update_service_now_data_source: ?CapabilityState = null,

    /// The ability to update Snowflake data sources.
    update_snowflake_data_source: ?CapabilityState = null,

    /// The ability to update Spark data sources.
    update_spark_data_source: ?CapabilityState = null,

    /// The ability to update SQL Server data sources.
    update_sql_server_data_source: ?CapabilityState = null,

    /// The ability to update Square data sources.
    update_square_data_source: ?CapabilityState = null,

    /// The ability to update Starburst data sources.
    update_starburst_data_source: ?CapabilityState = null,

    /// The ability to update Teradata data sources.
    update_teradata_data_source: ?CapabilityState = null,

    /// The ability to update Amazon Timestream data sources.
    update_timestream_data_source: ?CapabilityState = null,

    /// The ability to update Trino data sources.
    update_trino_data_source: ?CapabilityState = null,

    /// The ability to update Twitter data sources.
    update_twitter_data_source: ?CapabilityState = null,

    /// The ability to use Adobe Marketing Agent actions.
    use_adobe_action: ?CapabilityState = null,

    /// The ability to use internet to enhance results in Chat Agents, Flows, and
    /// Quick Research.
    /// Web search queries will be processed securely in an Amazon Web Services
    /// region `us-east-1`.
    use_agent_web_search: ?CapabilityState = null,

    /// The ability to use Airtable actions.
    use_airtable_action: ?CapabilityState = null,

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

    use_bedrock_managed_knowledge_base: ?CapabilityState = null,

    /// The ability to use Bedrock models for general knowledge step in flows.
    use_bedrock_models: ?CapabilityState = null,

    /// The ability to use Bee actions.
    use_bee_action: ?CapabilityState = null,

    /// The ability to use Box Agent actions.
    use_box_agent_action: ?CapabilityState = null,

    use_box_knowledge_base: ?CapabilityState = null,

    /// The ability to use Amazon Quick through the browser extension for Chrome,
    /// Firefox, and Edge.
    use_browser_extension: ?CapabilityState = null,

    /// The ability to use Canva Agent actions.
    use_canva_agent_action: ?CapabilityState = null,

    /// The ability to use Cisco Webex Meetings actions.
    use_cisco_webex_meetings_action: ?CapabilityState = null,

    /// The ability to use Cisco Webex Video Messaging Agent actions.
    use_cisco_webex_vidcast_action: ?CapabilityState = null,

    /// The ability to use Comprehend actions.
    use_comprehend_action: ?CapabilityState = null,

    /// The ability to use Comprehend Medical actions.
    use_comprehend_medical_action: ?CapabilityState = null,

    /// The ability to use Atlassian Confluence Cloud actions.
    use_confluence_action: ?CapabilityState = null,

    use_confluence_knowledge_base: ?CapabilityState = null,

    /// The ability to use Dropbox actions.
    use_dropbox_action: ?CapabilityState = null,

    /// The ability to use Dun and Bradstreet actions.
    use_dun_and_bradstreet_action: ?CapabilityState = null,

    /// The ability to use Amazon Quick through the Microsoft Excel add-in.
    use_excel_add_in_extension: ?CapabilityState = null,

    /// The ability to use FactSet actions.
    use_fact_set_action: ?CapabilityState = null,

    /// The ability to use Figma actions.
    use_figma_action: ?CapabilityState = null,

    /// The ability to use REST API connection actions.
    use_generic_http_action: ?CapabilityState = null,

    /// The ability to use GitHub actions.
    use_github_action: ?CapabilityState = null,

    /// The ability to use Gmail actions.
    use_gmail_action: ?CapabilityState = null,

    /// The ability to use Gong actions.
    use_gong_action: ?CapabilityState = null,

    /// The ability to use Google Analytics actions.
    use_google_analytics_action: ?CapabilityState = null,

    /// The ability to use Google Calendar actions.
    use_google_calendar_action: ?CapabilityState = null,

    /// The ability to use Google Chat actions.
    use_google_chat_action: ?CapabilityState = null,

    /// The ability to use Google Docs actions.
    use_google_docs_action: ?CapabilityState = null,

    /// The ability to use Google Drive actions.
    use_google_drive_action: ?CapabilityState = null,

    use_google_drive_knowledge_base: ?CapabilityState = null,

    /// The ability to use Google Meet actions.
    use_google_meet_action: ?CapabilityState = null,

    /// The ability to use Google Sheets actions.
    use_google_sheets_action: ?CapabilityState = null,

    /// The ability to use Google Slides actions.
    use_google_slides_action: ?CapabilityState = null,

    /// The ability to use HG Insights Agent actions.
    use_hg_insights_action: ?CapabilityState = null,

    /// The ability to use Hubspot actions.
    use_hubspot_action: ?CapabilityState = null,

    /// The ability to use HuggingFace actions.
    use_hugging_face_action: ?CapabilityState = null,

    use_idc_knowledge_base: ?CapabilityState = null,

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

    /// The ability to use Moody's GenAI Ready Data actions.
    use_moodys_action: ?CapabilityState = null,

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

    use_one_drive_knowledge_base: ?CapabilityState = null,

    /// The ability to use Microsoft OneNote actions.
    use_one_note_action: ?CapabilityState = null,

    /// The ability to use OpenAPI Specification actions.
    use_open_api_action: ?CapabilityState = null,

    /// The ability to use Amazon Quick through the Microsoft Outlook add-in.
    use_outlook_add_in_extension: ?CapabilityState = null,

    /// The ability to use PagerDuty Advance actions.
    use_pager_duty_action: ?CapabilityState = null,

    /// The ability to use PagerDuty Agent actions.
    use_pager_duty_agent_action: ?CapabilityState = null,

    /// The ability to use Amazon Quick through the Microsoft PowerPoint add-in.
    use_powerpoint_add_in_extension: ?CapabilityState = null,

    use_q_business_knowledge_base: ?CapabilityState = null,

    /// The ability to use QuickBooks actions.
    use_quick_books_action: ?CapabilityState = null,

    use_s3_knowledge_base: ?CapabilityState = null,

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

    use_share_point_knowledge_base: ?CapabilityState = null,

    /// The ability to use Shopify actions.
    use_shopify_action: ?CapabilityState = null,

    /// The ability to use Slack actions.
    use_slack_action: ?CapabilityState = null,

    /// The ability to use Smartsheet actions.
    use_smartsheet_action: ?CapabilityState = null,

    /// The ability to use Snowflake Cortex Agent actions.
    use_snow_flake_action: ?CapabilityState = null,

    /// The ability to use Textract actions.
    use_textract_action: ?CapabilityState = null,

    /// The ability to use Visier Agent actions.
    use_visier_agent_action: ?CapabilityState = null,

    use_web_crawler_knowledge_base: ?CapabilityState = null,

    /// The ability to use WhatsApp actions.
    use_whats_app_action: ?CapabilityState = null,

    /// The ability to use Amazon Quick through the Microsoft Word add-in.
    use_word_add_in_extension: ?CapabilityState = null,

    /// The ability to use Zapier Agent actions.
    use_zapier_action: ?CapabilityState = null,

    /// The ability to use Zendesk actions.
    use_zendesk_action: ?CapabilityState = null,

    /// The ability to use Zoom actions.
    use_zoom_action: ?CapabilityState = null,

    /// The ability to use ZoomInfo Agent actions.
    use_zoom_info_action: ?CapabilityState = null,

    /// The ability to view account SPICE capacity.
    view_account_spice_capacity: ?CapabilityState = null,

    /// The ability to perform actions using Visier Agent connectors.
    visier_agent_action: ?CapabilityState = null,

    web_crawler_knowledge_base: ?CapabilityState = null,

    /// The ability to perform actions using WhatsApp connectors.
    whats_app_action: ?CapabilityState = null,

    /// The ability to perform actions using Zapier Agent connectors.
    zapier_action: ?CapabilityState = null,

    /// The ability to perform actions using Zendesk connectors.
    zendesk_action: ?CapabilityState = null,

    /// The ability to perform actions using Zoom connectors.
    zoom_action: ?CapabilityState = null,

    /// The ability to perform actions using ZoomInfo Agent connectors.
    zoom_info_action: ?CapabilityState = null,

    pub const json_field_names = .{
        .access_apps_native_data_store = "AccessAppsNativeDataStore",
        .action = "Action",
        .add_or_run_anomaly_detection_for_analyses = "AddOrRunAnomalyDetectionForAnalyses",
        .adobe_action = "AdobeAction",
        .adobe_analytics_data_source = "AdobeAnalyticsDataSource",
        .airtable_action = "AirtableAction",
        .amazon_bedrock_ars_action = "AmazonBedrockARSAction",
        .amazon_bedrock_fs_action = "AmazonBedrockFSAction",
        .amazon_bedrock_krs_action = "AmazonBedrockKRSAction",
        .amazon_s_three_action = "AmazonSThreeAction",
        .analysis = "Analysis",
        .approve_flow_share_requests = "ApproveFlowShareRequests",
        .apps = "Apps",
        .asana_action = "AsanaAction",
        .athena_data_source = "AthenaDataSource",
        .aurora_data_source = "AuroraDataSource",
        .automate = "Automate",
        .bamboo_hr_action = "BambooHRAction",
        .bedrock_managed_knowledge_base = "BedrockManagedKnowledgeBase",
        .bee_action = "BeeAction",
        .box_agent_action = "BoxAgentAction",
        .box_knowledge_base = "BoxKnowledgeBase",
        .build_calculated_field_with_q = "BuildCalculatedFieldWithQ",
        .canva_agent_action = "CanvaAgentAction",
        .chat_agent = "ChatAgent",
        .cisco_webex_meetings_action = "CiscoWebexMeetingsAction",
        .cisco_webex_vidcast_action = "CiscoWebexVidcastAction",
        .comprehend_action = "ComprehendAction",
        .comprehend_medical_action = "ComprehendMedicalAction",
        .confluence_action = "ConfluenceAction",
        .confluence_knowledge_base = "ConfluenceKnowledgeBase",
        .create_adobe_analytics_data_source = "CreateAdobeAnalyticsDataSource",
        .create_and_update_adobe_action = "CreateAndUpdateAdobeAction",
        .create_and_update_airtable_action = "CreateAndUpdateAirtableAction",
        .create_and_update_amazon_bedrock_ars_action = "CreateAndUpdateAmazonBedrockARSAction",
        .create_and_update_amazon_bedrock_fs_action = "CreateAndUpdateAmazonBedrockFSAction",
        .create_and_update_amazon_bedrock_krs_action = "CreateAndUpdateAmazonBedrockKRSAction",
        .create_and_update_amazon_s_three_action = "CreateAndUpdateAmazonSThreeAction",
        .create_and_update_apps = "CreateAndUpdateApps",
        .create_and_update_asana_action = "CreateAndUpdateAsanaAction",
        .create_and_update_bamboo_hr_action = "CreateAndUpdateBambooHRAction",
        .create_and_update_bedrock_managed_knowledge_base = "CreateAndUpdateBedrockManagedKnowledgeBase",
        .create_and_update_bee_action = "CreateAndUpdateBeeAction",
        .create_and_update_box_agent_action = "CreateAndUpdateBoxAgentAction",
        .create_and_update_box_knowledge_base = "CreateAndUpdateBoxKnowledgeBase",
        .create_and_update_canva_agent_action = "CreateAndUpdateCanvaAgentAction",
        .create_and_update_cisco_webex_meetings_action = "CreateAndUpdateCiscoWebexMeetingsAction",
        .create_and_update_cisco_webex_vidcast_action = "CreateAndUpdateCiscoWebexVidcastAction",
        .create_and_update_comprehend_action = "CreateAndUpdateComprehendAction",
        .create_and_update_comprehend_medical_action = "CreateAndUpdateComprehendMedicalAction",
        .create_and_update_confluence_action = "CreateAndUpdateConfluenceAction",
        .create_and_update_confluence_knowledge_base = "CreateAndUpdateConfluenceKnowledgeBase",
        .create_and_update_dashboard_email_reports = "CreateAndUpdateDashboardEmailReports",
        .create_and_update_datasets = "CreateAndUpdateDatasets",
        .create_and_update_data_sources = "CreateAndUpdateDataSources",
        .create_and_update_dropbox_action = "CreateAndUpdateDropboxAction",
        .create_and_update_dun_and_bradstreet_action = "CreateAndUpdateDunAndBradstreetAction",
        .create_and_update_fact_set_action = "CreateAndUpdateFactSetAction",
        .create_and_update_figma_action = "CreateAndUpdateFigmaAction",
        .create_and_update_generic_http_action = "CreateAndUpdateGenericHTTPAction",
        .create_and_update_github_action = "CreateAndUpdateGithubAction",
        .create_and_update_gmail_action = "CreateAndUpdateGmailAction",
        .create_and_update_gong_action = "CreateAndUpdateGongAction",
        .create_and_update_google_analytics_action = "CreateAndUpdateGoogleAnalyticsAction",
        .create_and_update_google_calendar_action = "CreateAndUpdateGoogleCalendarAction",
        .create_and_update_google_chat_action = "CreateAndUpdateGoogleChatAction",
        .create_and_update_google_docs_action = "CreateAndUpdateGoogleDocsAction",
        .create_and_update_google_drive_action = "CreateAndUpdateGoogleDriveAction",
        .create_and_update_google_drive_knowledge_base = "CreateAndUpdateGoogleDriveKnowledgeBase",
        .create_and_update_google_meet_action = "CreateAndUpdateGoogleMeetAction",
        .create_and_update_google_sheets_action = "CreateAndUpdateGoogleSheetsAction",
        .create_and_update_google_slides_action = "CreateAndUpdateGoogleSlidesAction",
        .create_and_update_hg_insights_action = "CreateAndUpdateHGInsightsAction",
        .create_and_update_hubspot_action = "CreateAndUpdateHubspotAction",
        .create_and_update_hugging_face_action = "CreateAndUpdateHuggingFaceAction",
        .create_and_update_idc_knowledge_base = "CreateAndUpdateIDCKnowledgeBase",
        .create_and_update_intercom_action = "CreateAndUpdateIntercomAction",
        .create_and_update_jira_action = "CreateAndUpdateJiraAction",
        .create_and_update_knowledge_bases = "CreateAndUpdateKnowledgeBases",
        .create_and_update_linear_action = "CreateAndUpdateLinearAction",
        .create_and_update_mcp_action = "CreateAndUpdateMCPAction",
        .create_and_update_monday_action = "CreateAndUpdateMondayAction",
        .create_and_update_moodys_action = "CreateAndUpdateMoodysAction",
        .create_and_update_ms_exchange_action = "CreateAndUpdateMSExchangeAction",
        .create_and_update_ms_teams_action = "CreateAndUpdateMSTeamsAction",
        .create_and_update_new_relic_action = "CreateAndUpdateNewRelicAction",
        .create_and_update_notion_action = "CreateAndUpdateNotionAction",
        .create_and_update_one_drive_action = "CreateAndUpdateOneDriveAction",
        .create_and_update_one_drive_knowledge_base = "CreateAndUpdateOneDriveKnowledgeBase",
        .create_and_update_one_note_action = "CreateAndUpdateOneNoteAction",
        .create_and_update_open_api_action = "CreateAndUpdateOpenAPIAction",
        .create_and_update_pager_duty_action = "CreateAndUpdatePagerDutyAction",
        .create_and_update_pager_duty_agent_action = "CreateAndUpdatePagerDutyAgentAction",
        .create_and_update_q_business_knowledge_base = "CreateAndUpdateQBusinessKnowledgeBase",
        .create_and_update_quick_books_action = "CreateAndUpdateQuickBooksAction",
        .create_and_update_s3_knowledge_base = "CreateAndUpdateS3KnowledgeBase",
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
        .create_and_update_share_point_knowledge_base = "CreateAndUpdateSharePointKnowledgeBase",
        .create_and_update_shopify_action = "CreateAndUpdateShopifyAction",
        .create_and_update_slack_action = "CreateAndUpdateSlackAction",
        .create_and_update_smartsheet_action = "CreateAndUpdateSmartsheetAction",
        .create_and_update_snow_flake_action = "CreateAndUpdateSnowFlakeAction",
        .create_and_update_textract_action = "CreateAndUpdateTextractAction",
        .create_and_update_themes = "CreateAndUpdateThemes",
        .create_and_update_threshold_alerts = "CreateAndUpdateThresholdAlerts",
        .create_and_update_visier_agent_action = "CreateAndUpdateVisierAgentAction",
        .create_and_update_web_crawler_knowledge_base = "CreateAndUpdateWebCrawlerKnowledgeBase",
        .create_and_update_whats_app_action = "CreateAndUpdateWhatsAppAction",
        .create_and_update_zapier_action = "CreateAndUpdateZapierAction",
        .create_and_update_zendesk_action = "CreateAndUpdateZendeskAction",
        .create_and_update_zoom_action = "CreateAndUpdateZoomAction",
        .create_and_update_zoom_info_action = "CreateAndUpdateZoomInfoAction",
        .create_athena_data_source = "CreateAthenaDataSource",
        .create_aurora_data_source = "CreateAuroraDataSource",
        .create_chat_agents = "CreateChatAgents",
        .create_dashboard_executive_summary_with_q = "CreateDashboardExecutiveSummaryWithQ",
        .create_databricks_data_source = "CreateDatabricksDataSource",
        .create_db_2_data_source = "CreateDb2DataSource",
        .create_denodo_data_source = "CreateDenodoDataSource",
        .create_document_db_data_source = "CreateDocumentDbDataSource",
        .create_dremio_data_source = "CreateDremioDataSource",
        .create_dynamo_db_data_source = "CreateDynamoDbDataSource",
        .create_exasol_data_source = "CreateExasolDataSource",
        .create_file_data_source = "CreateFileDataSource",
        .create_git_hub_data_source = "CreateGitHubDataSource",
        .create_google_analytics_data_source = "CreateGoogleAnalyticsDataSource",
        .create_google_big_query_data_source = "CreateGoogleBigQueryDataSource",
        .create_google_sheets_data_source = "CreateGoogleSheetsDataSource",
        .create_impala_data_source = "CreateImpalaDataSource",
        .create_jira_data_source = "CreateJiraDataSource",
        .create_maria_db_data_source = "CreateMariaDbDataSource",
        .create_mongo_atlas_data_source = "CreateMongoAtlasDataSource",
        .create_mongo_db_data_source = "CreateMongoDbDataSource",
        .create_my_sql_data_source = "CreateMySqlDataSource",
        .create_open_search_data_source = "CreateOpenSearchDataSource",
        .create_oracle_data_source = "CreateOracleDataSource",
        .create_pay_pal_data_source = "CreatePayPalDataSource",
        .create_postgre_sql_data_source = "CreatePostgreSqlDataSource",
        .create_presto_data_source = "CreatePrestoDataSource",
        .create_radiant_data_source = "CreateRadiantDataSource",
        .create_rds_data_source = "CreateRdsDataSource",
        .create_redshift_auto_discovered_data_source = "CreateRedshiftAutoDiscoveredDataSource",
        .create_redshift_manual_data_source = "CreateRedshiftManualDataSource",
        .create_s3_analytics_data_source = "CreateS3AnalyticsDataSource",
        .create_s3_data_source = "CreateS3DataSource",
        .create_s3_tables_data_source = "CreateS3TablesDataSource",
        .create_salesforce_data_source = "CreateSalesforceDataSource",
        .create_sap_hana_data_source = "CreateSapHanaDataSource",
        .create_service_now_data_source = "CreateServiceNowDataSource",
        .create_shared_folders = "CreateSharedFolders",
        .create_snowflake_data_source = "CreateSnowflakeDataSource",
        .create_spaces = "CreateSpaces",
        .create_spark_data_source = "CreateSparkDataSource",
        .create_spice_dataset = "CreateSPICEDataset",
        .create_sql_server_data_source = "CreateSqlServerDataSource",
        .create_square_data_source = "CreateSquareDataSource",
        .create_starburst_data_source = "CreateStarburstDataSource",
        .create_teradata_data_source = "CreateTeradataDataSource",
        .create_timestream_data_source = "CreateTimestreamDataSource",
        .create_trino_data_source = "CreateTrinoDataSource",
        .create_twitter_data_source = "CreateTwitterDataSource",
        .dashboard = "Dashboard",
        .databricks_data_source = "DatabricksDataSource",
        .db_2_data_source = "Db2DataSource",
        .denodo_data_source = "DenodoDataSource",
        .document_db_data_source = "DocumentDbDataSource",
        .dremio_data_source = "DremioDataSource",
        .dropbox_action = "DropboxAction",
        .dun_and_bradstreet_action = "DunAndBradstreetAction",
        .dynamo_db_data_source = "DynamoDbDataSource",
        .edit_visual_with_q = "EditVisualWithQ",
        .exasol_data_source = "ExasolDataSource",
        .export_to_csv = "ExportToCsv",
        .export_to_csv_in_scheduled_reports = "ExportToCsvInScheduledReports",
        .export_to_excel = "ExportToExcel",
        .export_to_excel_in_scheduled_reports = "ExportToExcelInScheduledReports",
        .export_to_pdf = "ExportToPdf",
        .export_to_pdf_in_scheduled_reports = "ExportToPdfInScheduledReports",
        .extension = "Extension",
        .fact_set_action = "FactSetAction",
        .figma_action = "FigmaAction",
        .file_data_source = "FileDataSource",
        .flow = "Flow",
        .generate_analyses = "GenerateAnalyses",
        .generic_http_action = "GenericHTTPAction",
        .github_action = "GithubAction",
        .git_hub_data_source = "GitHubDataSource",
        .gmail_action = "GmailAction",
        .gong_action = "GongAction",
        .google_analytics_action = "GoogleAnalyticsAction",
        .google_analytics_data_source = "GoogleAnalyticsDataSource",
        .google_big_query_data_source = "GoogleBigQueryDataSource",
        .google_calendar_action = "GoogleCalendarAction",
        .google_chat_action = "GoogleChatAction",
        .google_docs_action = "GoogleDocsAction",
        .google_drive_action = "GoogleDriveAction",
        .google_drive_knowledge_base = "GoogleDriveKnowledgeBase",
        .google_meet_action = "GoogleMeetAction",
        .google_sheets_action = "GoogleSheetsAction",
        .google_sheets_data_source = "GoogleSheetsDataSource",
        .google_slides_action = "GoogleSlidesAction",
        .hg_insights_action = "HGInsightsAction",
        .hubspot_action = "HubspotAction",
        .hugging_face_action = "HuggingFaceAction",
        .idc_knowledge_base = "IDCKnowledgeBase",
        .impala_data_source = "ImpalaDataSource",
        .inbound_email_trigger = "InboundEmailTrigger",
        .include_content_in_scheduled_reports_email = "IncludeContentInScheduledReportsEmail",
        .intercom_action = "IntercomAction",
        .invoke_apps_ai_inference = "InvokeAppsAIInference",
        .jira_action = "JiraAction",
        .jira_data_source = "JiraDataSource",
        .knowledge_base = "KnowledgeBase",
        .linear_action = "LinearAction",
        .manage_shared_folders = "ManageSharedFolders",
        .maria_db_data_source = "MariaDbDataSource",
        .mcp_action = "MCPAction",
        .monday_action = "MondayAction",
        .mongo_atlas_data_source = "MongoAtlasDataSource",
        .mongo_db_data_source = "MongoDbDataSource",
        .moodys_action = "MoodysAction",
        .ms_exchange_action = "MSExchangeAction",
        .ms_teams_action = "MSTeamsAction",
        .my_sql_data_source = "MySqlDataSource",
        .new_relic_action = "NewRelicAction",
        .notion_action = "NotionAction",
        .one_drive_action = "OneDriveAction",
        .one_drive_knowledge_base = "OneDriveKnowledgeBase",
        .one_note_action = "OneNoteAction",
        .open_api_action = "OpenAPIAction",
        .open_search_data_source = "OpenSearchDataSource",
        .oracle_data_source = "OracleDataSource",
        .pager_duty_action = "PagerDutyAction",
        .pager_duty_agent_action = "PagerDutyAgentAction",
        .pay_pal_data_source = "PayPalDataSource",
        .perform_flow_ui_task = "PerformFlowUiTask",
        .postgre_sql_data_source = "PostgreSqlDataSource",
        .presto_data_source = "PrestoDataSource",
        .print_reports = "PrintReports",
        .publish_without_approval = "PublishWithoutApproval",
        .q_business_knowledge_base = "QBusinessKnowledgeBase",
        .quick_books_action = "QuickBooksAction",
        .quick_event_trigger = "QuickEventTrigger",
        .radiant_data_source = "RadiantDataSource",
        .rds_data_source = "RdsDataSource",
        .redshift_auto_discovered_data_source = "RedshiftAutoDiscoveredDataSource",
        .redshift_manual_data_source = "RedshiftManualDataSource",
        .rename_shared_folders = "RenameSharedFolders",
        .research = "Research",
        .s3_analytics_data_source = "S3AnalyticsDataSource",
        .s3_data_source = "S3DataSource",
        .s3_knowledge_base = "S3KnowledgeBase",
        .s3_tables_data_source = "S3TablesDataSource",
        .salesforce_action = "SalesforceAction",
        .salesforce_data_source = "SalesforceDataSource",
        .sand_p_global_energy_action = "SandPGlobalEnergyAction",
        .sand_pgmi_action = "SandPGMIAction",
        .sap_bill_of_material_action = "SAPBillOfMaterialAction",
        .sap_business_partner_action = "SAPBusinessPartnerAction",
        .sap_hana_data_source = "SapHanaDataSource",
        .sap_material_stock_action = "SAPMaterialStockAction",
        .sap_physical_inventory_action = "SAPPhysicalInventoryAction",
        .sap_product_master_data_action = "SAPProductMasterDataAction",
        .scenario = "Scenario",
        .schedule_trigger = "ScheduleTrigger",
        .self_upgrade_user_role = "SelfUpgradeUserRole",
        .service_now_action = "ServiceNowAction",
        .service_now_data_source = "ServiceNowDataSource",
        .share_adobe_action = "ShareAdobeAction",
        .share_adobe_analytics_data_source = "ShareAdobeAnalyticsDataSource",
        .share_airtable_action = "ShareAirtableAction",
        .share_amazon_bedrock_ars_action = "ShareAmazonBedrockARSAction",
        .share_amazon_bedrock_fs_action = "ShareAmazonBedrockFSAction",
        .share_amazon_bedrock_krs_action = "ShareAmazonBedrockKRSAction",
        .share_amazon_s_three_action = "ShareAmazonSThreeAction",
        .share_analyses = "ShareAnalyses",
        .share_apps = "ShareApps",
        .share_asana_action = "ShareAsanaAction",
        .share_athena_data_source = "ShareAthenaDataSource",
        .share_aurora_data_source = "ShareAuroraDataSource",
        .share_bamboo_hr_action = "ShareBambooHRAction",
        .share_bedrock_managed_knowledge_base = "ShareBedrockManagedKnowledgeBase",
        .share_bee_action = "ShareBeeAction",
        .share_box_agent_action = "ShareBoxAgentAction",
        .share_box_knowledge_base = "ShareBoxKnowledgeBase",
        .share_canva_agent_action = "ShareCanvaAgentAction",
        .share_chat_agents = "ShareChatAgents",
        .share_cisco_webex_meetings_action = "ShareCiscoWebexMeetingsAction",
        .share_cisco_webex_vidcast_action = "ShareCiscoWebexVidcastAction",
        .share_comprehend_action = "ShareComprehendAction",
        .share_comprehend_medical_action = "ShareComprehendMedicalAction",
        .share_confluence_action = "ShareConfluenceAction",
        .share_confluence_knowledge_base = "ShareConfluenceKnowledgeBase",
        .share_dashboards = "ShareDashboards",
        .share_databricks_data_source = "ShareDatabricksDataSource",
        .share_datasets = "ShareDatasets",
        .share_data_sources = "ShareDataSources",
        .share_db_2_data_source = "ShareDb2DataSource",
        .share_denodo_data_source = "ShareDenodoDataSource",
        .share_document_db_data_source = "ShareDocumentDbDataSource",
        .share_dremio_data_source = "ShareDremioDataSource",
        .share_dropbox_action = "ShareDropboxAction",
        .share_dun_and_bradstreet_action = "ShareDunAndBradstreetAction",
        .share_dynamo_db_data_source = "ShareDynamoDbDataSource",
        .share_exasol_data_source = "ShareExasolDataSource",
        .share_fact_set_action = "ShareFactSetAction",
        .share_figma_action = "ShareFigmaAction",
        .share_file_data_source = "ShareFileDataSource",
        .share_generic_http_action = "ShareGenericHTTPAction",
        .share_github_action = "ShareGithubAction",
        .share_git_hub_data_source = "ShareGitHubDataSource",
        .share_gmail_action = "ShareGmailAction",
        .share_gong_action = "ShareGongAction",
        .share_google_analytics_action = "ShareGoogleAnalyticsAction",
        .share_google_analytics_data_source = "ShareGoogleAnalyticsDataSource",
        .share_google_big_query_data_source = "ShareGoogleBigQueryDataSource",
        .share_google_calendar_action = "ShareGoogleCalendarAction",
        .share_google_chat_action = "ShareGoogleChatAction",
        .share_google_docs_action = "ShareGoogleDocsAction",
        .share_google_drive_action = "ShareGoogleDriveAction",
        .share_google_drive_knowledge_base = "ShareGoogleDriveKnowledgeBase",
        .share_google_meet_action = "ShareGoogleMeetAction",
        .share_google_sheets_action = "ShareGoogleSheetsAction",
        .share_google_sheets_data_source = "ShareGoogleSheetsDataSource",
        .share_google_slides_action = "ShareGoogleSlidesAction",
        .share_hg_insights_action = "ShareHGInsightsAction",
        .share_hubspot_action = "ShareHubspotAction",
        .share_hugging_face_action = "ShareHuggingFaceAction",
        .share_idc_knowledge_base = "ShareIDCKnowledgeBase",
        .share_impala_data_source = "ShareImpalaDataSource",
        .share_intercom_action = "ShareIntercomAction",
        .share_jira_action = "ShareJiraAction",
        .share_jira_data_source = "ShareJiraDataSource",
        .share_knowledge_bases = "ShareKnowledgeBases",
        .share_linear_action = "ShareLinearAction",
        .share_maria_db_data_source = "ShareMariaDbDataSource",
        .share_mcp_action = "ShareMCPAction",
        .share_monday_action = "ShareMondayAction",
        .share_mongo_atlas_data_source = "ShareMongoAtlasDataSource",
        .share_mongo_db_data_source = "ShareMongoDbDataSource",
        .share_moodys_action = "ShareMoodysAction",
        .share_ms_exchange_action = "ShareMSExchangeAction",
        .share_ms_teams_action = "ShareMSTeamsAction",
        .share_my_sql_data_source = "ShareMySqlDataSource",
        .share_new_relic_action = "ShareNewRelicAction",
        .share_notion_action = "ShareNotionAction",
        .share_one_drive_action = "ShareOneDriveAction",
        .share_one_drive_knowledge_base = "ShareOneDriveKnowledgeBase",
        .share_one_note_action = "ShareOneNoteAction",
        .share_open_api_action = "ShareOpenAPIAction",
        .share_open_search_data_source = "ShareOpenSearchDataSource",
        .share_oracle_data_source = "ShareOracleDataSource",
        .share_pager_duty_action = "SharePagerDutyAction",
        .share_pager_duty_agent_action = "SharePagerDutyAgentAction",
        .share_pay_pal_data_source = "SharePayPalDataSource",
        .share_point_action = "SharePointAction",
        .share_point_knowledge_base = "SharePointKnowledgeBase",
        .share_postgre_sql_data_source = "SharePostgreSqlDataSource",
        .share_presto_data_source = "SharePrestoDataSource",
        .share_q_business_knowledge_base = "ShareQBusinessKnowledgeBase",
        .share_quick_books_action = "ShareQuickBooksAction",
        .share_radiant_data_source = "ShareRadiantDataSource",
        .share_rds_data_source = "ShareRdsDataSource",
        .share_redshift_auto_discovered_data_source = "ShareRedshiftAutoDiscoveredDataSource",
        .share_redshift_manual_data_source = "ShareRedshiftManualDataSource",
        .share_s3_analytics_data_source = "ShareS3AnalyticsDataSource",
        .share_s3_data_source = "ShareS3DataSource",
        .share_s3_knowledge_base = "ShareS3KnowledgeBase",
        .share_s3_tables_data_source = "ShareS3TablesDataSource",
        .share_salesforce_action = "ShareSalesforceAction",
        .share_salesforce_data_source = "ShareSalesforceDataSource",
        .share_sand_p_global_energy_action = "ShareSandPGlobalEnergyAction",
        .share_sand_pgmi_action = "ShareSandPGMIAction",
        .share_sap_bill_of_material_action = "ShareSAPBillOfMaterialAction",
        .share_sap_business_partner_action = "ShareSAPBusinessPartnerAction",
        .share_sap_hana_data_source = "ShareSapHanaDataSource",
        .share_sap_material_stock_action = "ShareSAPMaterialStockAction",
        .share_sap_physical_inventory_action = "ShareSAPPhysicalInventoryAction",
        .share_sap_product_master_data_action = "ShareSAPProductMasterDataAction",
        .share_service_now_action = "ShareServiceNowAction",
        .share_service_now_data_source = "ShareServiceNowDataSource",
        .share_share_point_action = "ShareSharePointAction",
        .share_share_point_knowledge_base = "ShareSharePointKnowledgeBase",
        .share_shopify_action = "ShareShopifyAction",
        .share_slack_action = "ShareSlackAction",
        .share_smartsheet_action = "ShareSmartsheetAction",
        .share_snow_flake_action = "ShareSnowFlakeAction",
        .share_snowflake_data_source = "ShareSnowflakeDataSource",
        .share_spaces = "ShareSpaces",
        .share_spark_data_source = "ShareSparkDataSource",
        .share_sql_server_data_source = "ShareSqlServerDataSource",
        .share_square_data_source = "ShareSquareDataSource",
        .share_starburst_data_source = "ShareStarburstDataSource",
        .share_teradata_data_source = "ShareTeradataDataSource",
        .share_textract_action = "ShareTextractAction",
        .share_timestream_data_source = "ShareTimestreamDataSource",
        .share_trino_data_source = "ShareTrinoDataSource",
        .share_twitter_data_source = "ShareTwitterDataSource",
        .share_visier_agent_action = "ShareVisierAgentAction",
        .share_web_crawler_knowledge_base = "ShareWebCrawlerKnowledgeBase",
        .share_whats_app_action = "ShareWhatsAppAction",
        .share_zapier_action = "ShareZapierAction",
        .share_zendesk_action = "ShareZendeskAction",
        .share_zoom_action = "ShareZoomAction",
        .share_zoom_info_action = "ShareZoomInfoAction",
        .shopify_action = "ShopifyAction",
        .slack_action = "SlackAction",
        .smartsheet_action = "SmartsheetAction",
        .snow_flake_action = "SnowFlakeAction",
        .snowflake_data_source = "SnowflakeDataSource",
        .space = "Space",
        .spark_data_source = "SparkDataSource",
        .sql_server_data_source = "SqlServerDataSource",
        .square_data_source = "SquareDataSource",
        .starburst_data_source = "StarburstDataSource",
        .story = "Story",
        .subscribe_dashboard_email_reports = "SubscribeDashboardEmailReports",
        .teradata_data_source = "TeradataDataSource",
        .textract_action = "TextractAction",
        .timestream_data_source = "TimestreamDataSource",
        .topic = "Topic",
        .trigger = "Trigger",
        .trino_data_source = "TrinoDataSource",
        .twitter_data_source = "TwitterDataSource",
        .update_adobe_analytics_data_source = "UpdateAdobeAnalyticsDataSource",
        .update_athena_data_source = "UpdateAthenaDataSource",
        .update_aurora_data_source = "UpdateAuroraDataSource",
        .update_databricks_data_source = "UpdateDatabricksDataSource",
        .update_db_2_data_source = "UpdateDb2DataSource",
        .update_denodo_data_source = "UpdateDenodoDataSource",
        .update_document_db_data_source = "UpdateDocumentDbDataSource",
        .update_dremio_data_source = "UpdateDremioDataSource",
        .update_dynamo_db_data_source = "UpdateDynamoDbDataSource",
        .update_exasol_data_source = "UpdateExasolDataSource",
        .update_file_data_source = "UpdateFileDataSource",
        .update_git_hub_data_source = "UpdateGitHubDataSource",
        .update_google_analytics_data_source = "UpdateGoogleAnalyticsDataSource",
        .update_google_big_query_data_source = "UpdateGoogleBigQueryDataSource",
        .update_google_sheets_data_source = "UpdateGoogleSheetsDataSource",
        .update_impala_data_source = "UpdateImpalaDataSource",
        .update_jira_data_source = "UpdateJiraDataSource",
        .update_maria_db_data_source = "UpdateMariaDbDataSource",
        .update_mongo_atlas_data_source = "UpdateMongoAtlasDataSource",
        .update_mongo_db_data_source = "UpdateMongoDbDataSource",
        .update_my_sql_data_source = "UpdateMySqlDataSource",
        .update_open_search_data_source = "UpdateOpenSearchDataSource",
        .update_oracle_data_source = "UpdateOracleDataSource",
        .update_pay_pal_data_source = "UpdatePayPalDataSource",
        .update_postgre_sql_data_source = "UpdatePostgreSqlDataSource",
        .update_presto_data_source = "UpdatePrestoDataSource",
        .update_radiant_data_source = "UpdateRadiantDataSource",
        .update_rds_data_source = "UpdateRdsDataSource",
        .update_redshift_auto_discovered_data_source = "UpdateRedshiftAutoDiscoveredDataSource",
        .update_redshift_manual_data_source = "UpdateRedshiftManualDataSource",
        .update_s3_analytics_data_source = "UpdateS3AnalyticsDataSource",
        .update_s3_data_source = "UpdateS3DataSource",
        .update_s3_tables_data_source = "UpdateS3TablesDataSource",
        .update_salesforce_data_source = "UpdateSalesforceDataSource",
        .update_sap_hana_data_source = "UpdateSapHanaDataSource",
        .update_service_now_data_source = "UpdateServiceNowDataSource",
        .update_snowflake_data_source = "UpdateSnowflakeDataSource",
        .update_spark_data_source = "UpdateSparkDataSource",
        .update_sql_server_data_source = "UpdateSqlServerDataSource",
        .update_square_data_source = "UpdateSquareDataSource",
        .update_starburst_data_source = "UpdateStarburstDataSource",
        .update_teradata_data_source = "UpdateTeradataDataSource",
        .update_timestream_data_source = "UpdateTimestreamDataSource",
        .update_trino_data_source = "UpdateTrinoDataSource",
        .update_twitter_data_source = "UpdateTwitterDataSource",
        .use_adobe_action = "UseAdobeAction",
        .use_agent_web_search = "UseAgentWebSearch",
        .use_airtable_action = "UseAirtableAction",
        .use_amazon_bedrock_ars_action = "UseAmazonBedrockARSAction",
        .use_amazon_bedrock_fs_action = "UseAmazonBedrockFSAction",
        .use_amazon_bedrock_krs_action = "UseAmazonBedrockKRSAction",
        .use_amazon_s_three_action = "UseAmazonSThreeAction",
        .use_asana_action = "UseAsanaAction",
        .use_bamboo_hr_action = "UseBambooHRAction",
        .use_bedrock_managed_knowledge_base = "UseBedrockManagedKnowledgeBase",
        .use_bedrock_models = "UseBedrockModels",
        .use_bee_action = "UseBeeAction",
        .use_box_agent_action = "UseBoxAgentAction",
        .use_box_knowledge_base = "UseBoxKnowledgeBase",
        .use_browser_extension = "UseBrowserExtension",
        .use_canva_agent_action = "UseCanvaAgentAction",
        .use_cisco_webex_meetings_action = "UseCiscoWebexMeetingsAction",
        .use_cisco_webex_vidcast_action = "UseCiscoWebexVidcastAction",
        .use_comprehend_action = "UseComprehendAction",
        .use_comprehend_medical_action = "UseComprehendMedicalAction",
        .use_confluence_action = "UseConfluenceAction",
        .use_confluence_knowledge_base = "UseConfluenceKnowledgeBase",
        .use_dropbox_action = "UseDropboxAction",
        .use_dun_and_bradstreet_action = "UseDunAndBradstreetAction",
        .use_excel_add_in_extension = "UseExcelAddInExtension",
        .use_fact_set_action = "UseFactSetAction",
        .use_figma_action = "UseFigmaAction",
        .use_generic_http_action = "UseGenericHTTPAction",
        .use_github_action = "UseGithubAction",
        .use_gmail_action = "UseGmailAction",
        .use_gong_action = "UseGongAction",
        .use_google_analytics_action = "UseGoogleAnalyticsAction",
        .use_google_calendar_action = "UseGoogleCalendarAction",
        .use_google_chat_action = "UseGoogleChatAction",
        .use_google_docs_action = "UseGoogleDocsAction",
        .use_google_drive_action = "UseGoogleDriveAction",
        .use_google_drive_knowledge_base = "UseGoogleDriveKnowledgeBase",
        .use_google_meet_action = "UseGoogleMeetAction",
        .use_google_sheets_action = "UseGoogleSheetsAction",
        .use_google_slides_action = "UseGoogleSlidesAction",
        .use_hg_insights_action = "UseHGInsightsAction",
        .use_hubspot_action = "UseHubspotAction",
        .use_hugging_face_action = "UseHuggingFaceAction",
        .use_idc_knowledge_base = "UseIDCKnowledgeBase",
        .use_intercom_action = "UseIntercomAction",
        .use_jira_action = "UseJiraAction",
        .use_linear_action = "UseLinearAction",
        .use_mcp_action = "UseMCPAction",
        .use_monday_action = "UseMondayAction",
        .use_moodys_action = "UseMoodysAction",
        .use_ms_exchange_action = "UseMSExchangeAction",
        .use_ms_teams_action = "UseMSTeamsAction",
        .use_new_relic_action = "UseNewRelicAction",
        .use_notion_action = "UseNotionAction",
        .use_one_drive_action = "UseOneDriveAction",
        .use_one_drive_knowledge_base = "UseOneDriveKnowledgeBase",
        .use_one_note_action = "UseOneNoteAction",
        .use_open_api_action = "UseOpenAPIAction",
        .use_outlook_add_in_extension = "UseOutlookAddInExtension",
        .use_pager_duty_action = "UsePagerDutyAction",
        .use_pager_duty_agent_action = "UsePagerDutyAgentAction",
        .use_powerpoint_add_in_extension = "UsePowerpointAddInExtension",
        .use_q_business_knowledge_base = "UseQBusinessKnowledgeBase",
        .use_quick_books_action = "UseQuickBooksAction",
        .use_s3_knowledge_base = "UseS3KnowledgeBase",
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
        .use_share_point_knowledge_base = "UseSharePointKnowledgeBase",
        .use_shopify_action = "UseShopifyAction",
        .use_slack_action = "UseSlackAction",
        .use_smartsheet_action = "UseSmartsheetAction",
        .use_snow_flake_action = "UseSnowFlakeAction",
        .use_textract_action = "UseTextractAction",
        .use_visier_agent_action = "UseVisierAgentAction",
        .use_web_crawler_knowledge_base = "UseWebCrawlerKnowledgeBase",
        .use_whats_app_action = "UseWhatsAppAction",
        .use_word_add_in_extension = "UseWordAddInExtension",
        .use_zapier_action = "UseZapierAction",
        .use_zendesk_action = "UseZendeskAction",
        .use_zoom_action = "UseZoomAction",
        .use_zoom_info_action = "UseZoomInfoAction",
        .view_account_spice_capacity = "ViewAccountSPICECapacity",
        .visier_agent_action = "VisierAgentAction",
        .web_crawler_knowledge_base = "WebCrawlerKnowledgeBase",
        .whats_app_action = "WhatsAppAction",
        .zapier_action = "ZapierAction",
        .zendesk_action = "ZendeskAction",
        .zoom_action = "ZoomAction",
        .zoom_info_action = "ZoomInfoAction",
    };
};
