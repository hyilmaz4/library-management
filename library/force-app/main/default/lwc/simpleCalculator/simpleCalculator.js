import { LightningElement } from 'lwc';


export default class LWC05_SimpleMath extends LightningElement {
  numberX;
  numberY;
  result;

  handleChangeNumber(event){
    if(event.target.name==='xnum'){
      this.numberX=event.target.value;
      

    }else if(event.target.name==='ynum'){
      this.numberY=event.target.value;
    }

  }

  handleClickSum(){
    this.result=parseInt(this.numberX)+parseInt(this.numberY);
  }

  handleClickSub(){
    this.result=parseInt(this.numberX)-parseInt(this.numberY);
  }

  handleClickMul(){
    this.result=parseInt(this.numberX)*parseInt(this.numberY);
  }

  handleClickDiv(){
    this.result=parseInt(this.numberX)/parseInt(this.numberY);
  }



}