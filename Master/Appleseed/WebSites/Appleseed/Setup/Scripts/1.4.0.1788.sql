if exists (select * from dbo.sysobjects where id = object_id(N'rb_AddTab') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure rb_AddTab
GO


CREATE PROCEDURE rb_AddTab
(
   @PortalID		int,		/* Required Field  */
   @ParentTabID		int,            /*   New Parm - NULL Allowed    */
   @TabName		nvarchar(50),   /* Required Field  */
   @TabOrder		int,            /* Required Field  */ 
   @AuthorizedRoles	nvarchar (256), /* NULL Allowed    */
   @ShowMobile		bit = 0,        /*   New Parm - false by default */
   @MobileTabName	nvarchar(50),   /* Required Field  */
   @TabID		int OUTPUT      /* Returned value */

)
 
AS

  IF (@ParentTabID = 0)
  BEGIN  
    set @ParentTabID = NULL
  END


INSERT INTO rb_Tabs
(
   ParentTabID,  /* New parm */
    TabOrder,
    PortalID,
    TabName,
    MobileTabName,
    AuthorizedRoles,
    ShowMobile
    
)


VALUES
(
   @ParentTabID, 
   @TabOrder,
   @PortalID,
   @TabName,
   @MobileTabName,
   @AuthorizedRoles,
   @ShowMobile
    
)

SELECT
    @TabID = @@IDENTITY
GO


