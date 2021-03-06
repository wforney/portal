
/* Only Get HtmlModules from given PortalID*/
IF EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[rb_GetHtmlModuleByPortalID]'))
BEGIN
 DROP PROCEDURE [dbo].[rb_GetHtmlModuleByPortalID]
END
GO

Create Procedure [dbo].[rb_GetHtmlModuleByPortalID]
(
@PortalID  int
)
AS
BEGIN
DECLARE @ALLMODULES TABLE
(
	ModuleID int,
	HtmlModule nvarchar(500),
	ModuleTitle nvarchar(500),
	PageOrder int
)

INSERT INTO @ALLMODULES
SELECT      0 AS ModuleID, 'NO_MODULE' ModuleTitle1, 'NO_MODULE' ModuleTitle, -1 AS PageOrder
UNION
	SELECT     rb_Modules.ModuleID,rb_Modules.ModuleTitle , rb_Pages.PageName + '/' + rb_Modules.ModuleTitle + ' (' + rb_GeneralModuleDefinitions.FriendlyName + ')' AS ModuleTitle, rb_Pages.PageOrder
	FROM         rb_Modules INNER JOIN
	                      rb_Pages ON rb_Modules.TabID = rb_Pages.PageID INNER JOIN
	                      rb_ModuleDefinitions ON rb_Modules.ModuleDefID = rb_ModuleDefinitions.ModuleDefID INNER JOIN
	                      rb_GeneralModuleDefinitions ON rb_ModuleDefinitions.GeneralModDefID = rb_GeneralModuleDefinitions.GeneralModDefID
	WHERE     (rb_Pages.PortalID = @PortalID) AND (rb_GeneralModuleDefinitions.GeneralModDefID <> 'F9F9C3A4-6E16-43b4-B540-984DDB5F1CD2' AND 
	                      rb_GeneralModuleDefinitions.GeneralModDefID <> 'F9F9C3A4-6E16-43b4-B540-984DDB5F1CD0') AND 
						  rb_GeneralModuleDefinitions.GeneralModDefID='0B113F51-FEA3-499A-98E7-7B83C192FDBB'
	ORDER BY PageOrder, ModuleTitle

select ModuleID,HtmlModule from @ALLMODULES
END


