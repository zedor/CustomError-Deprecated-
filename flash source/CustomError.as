package  {
	
	import flash.display.MovieClip;
	import flash.utils.getDefinitionByName;
	
	import scaleform.gfx.InteractiveObjectEx;
	
	import ValveLib.Globals;
	import ValveLib.ResizeManager;
			
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	
	public class CustomError extends MovieClip {
		
		public var gameAPI:Object;
		public var globals:Object;
		public var elementName:String;
		public var _trueX:Number;
		public var _trueY:Number;
		
		public function CustomError() {
			txtError.txt.autoSize = "center";
		}
		
		public function onLoaded() : void {			
			//make this UI visible
			visible = true;
			
			//let the client rescale the UI
			Globals.instance.resizeManager.AddListener(this);
			this.gameAPI.SubscribeToGameEvent("custom_error_show", this.showError);
			//trace("[CustomError]");
			
			scaleform.gfx.InteractiveObjectEx.setHitTestDisable(this.txtError, true);
			
			//txt_error = replaceWithValveComponent(txtError, "error_msg");
		}
		
		public function showError( args:Object ){
			var pID:int = this.globals.Players.GetLocalPlayer();
			
			if( pID == args.player_ID ) {
				//trace('[showError] ' + args._error );
				txtError.scaleX = 1.5;
				txtError.scaleY = 1.5;
				txtError.alpha = 0;
				txtError.txt.text = args._error;
				txtError.txt.x = -(txtError.txt.width/2);
				txtError.txt.y = -(txtError.txt.height/2);
				
				txtError.x = _trueX;
				txtError.y = _trueY+(txtError.txt.height/2);
				
				TweenLite.to(
    				txtError,                     //movieclip to be tweened
    				0.25,                             //duration
    				{	
						overwrite:1,
						scaleX:1,
						scaleY:1,
        				alpha:1,                     //target alpha
        				onComplete:function(){       //onComplete callback
            				TweenLite.to(txtError, 0.25, { delay:1, alpha:0 });
        				}
    				}
				);
			}
		}
		
		public function onResize(re:ResizeManager) : * {
			re.ResetPositionByPixel(this.txtError, ValveLib.ResizeManager.SCALE_USING_VERTICAL, ValveLib.ResizeManager.REFERENCE_CENTER_X, 0, ValveLib.ResizeManager.ALIGN_CENTER, ValveLib.ResizeManager.REFERENCE_CENTER_Y, 150, ValveLib.ResizeManager.ALIGN_CENTER);
			_trueX = txtError.x;
			_trueY = txtError.y;
		}
	}
	
}
