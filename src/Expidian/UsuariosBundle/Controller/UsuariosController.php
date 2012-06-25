<?php

namespace Expidian\UsuariosBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;

use Expidian\GlobalBundle\Entity\Usuarios;
use Expidian\GlobalBundle\Entity\Personas;
use Expidian\GlobalBundle\Entity\Perfiles;
use Expidian\GlobalBundle\Entity\Paises;
use Expidian\GlobalBundle\Entity\Estados;

use Expidian\GlobalBundle\Form\PersonaType;
use Expidian\GlobalBundle\Form\UsuariosType;

use Expidian\UsuariosBundle\Controller\Session\SessionManager;

/**
 * Description of UsuariosController
 *
 * @author autana
 */
class UsuariosController extends Controller {

    
    /**
     * PErmite visualizar página inicial del módulo de usuarios.
     *  
     * @return Symfony\Component\HttpFoundation\Response
     */
    public function indexAction() {
        $request = $this->getRequest();
        $session = $request->getSession();
                
        $sm = new SessionManager($session);
        $sm->readSession();
        
        if($sm->getSession_is_open()){
            
            $usuario_obj = $sm->getUsuario();
            $breadcrumb = array(array('text'=>'Usuarios','url'=>$this->generateUrl('ExpUsuariosList')),array('text'=>'Lista','url'=>''));
            
            if($usuario_obj->getPerfil()->getPerfil()=='Administrador' || $usuario_obj->getPerfil()->getPerfil()=='Abogado Coordinador'){
                return $this->render('ExpidianUsuariosBundle:Usuarios:list_usuarios.html.twig', array('breadcrumb'=>$breadcrumb,'usuario'=>$usuario_obj));
            }else{
                return $this->render('ExpidianGlobalBundle::dialog_msj.html.twig', array('msj'=>'Su perfil no posee permisos para efectuar esta acci&oacute;n en el sistema.','class'=>'errorDialogBox', 'breadcrumb'=>$breadcrumb,'usuario'=>$usuario_obj));
            }
        }else{
            $estatus = "inicio";
            return $this->render('ExpidianUsuariosBundle:Login:login.html.twig', array('accion'=>'login','estatus'=>$estatus));
        } 
    }
    
    /**
     * Permite el Registro de un nuevo Usuario al Sistema. Si el método por el que se llama a esta función es "GET" se mostrará el formulario para el ingreso de los datos del nuevo usuario. Si el método es "POST" se validará el formulario y se procederá si la validación es exitosa al registro del nuevo usuario al sistema.
     * 
     * @return Symfony\Component\HttpFoundation\Response
     */
    public function newAction() {
        
        $request = $this->getRequest();
        $session = $request->getSession();
                
        $sm = new SessionManager($session);
        $sm->readSession();
        $usuario_obj = $sm->getUsuario();
        
        if($sm->getSession_is_open()){
            
            if($usuario_obj->getPerfil()->getPerfil()=='Administrador' || $usuario_obj->getPerfil()->getPerfil()=='Abogado Coordinador'){
                
                $breadcrumb = array(array('text'=>'Usuarios','url'=>$this->generateUrl('ExpUsuariosList')),array('text'=>'Nuevo','url'=>''));
                
                $usuario = new Usuarios();
                $persona = new Personas();
                
                $usuario->setPersona($persona);
                
                $form = $this->createForm(new UsuariosType(),$usuario);
                
                //Si la petición viene por método post se reciben los datos del formulario se validan los mismos y se crea un nuevo usuario.
                if($request->getMethod()=='POST'){
                    
                    //Con esta sentencia vinculo los valores proporcionados por el formulario a cada uno de los atributos del objeto para que fué configurado. En este caso $usuario
                    $form->bindRequest($request);
                    $em = $this->getDoctrine()->getEntityManager();
                    
                    if($form->isValid()){
                                                
                        $result = $em->getRepository('ExpidianGlobalBundle:Usuarios')->RegistrarNuevoUsuario($usuario, $em);
                        
                        if($result){
                            $msj = 'El Usuario <b>'.$usuario->getPersona().'</b> con ha sido Registrado Existosamente con Login de Usuario <b>'.$usuario->getUsuario().'</b>. Para agregar un nuevo usuario haga click <a href='.$this->generateUrl('ExpUsuariosNew').'>aqu&iacute;</a>';
                            $class_style = 'successDialogBox';
                        }else{
                            $msj = 'Ha ocurrido un error en el sistema. Vuelva a intentarlo más tarde. Para agregar un nuevo usuario haga click <a href='.$this->generateUrl('ExpUsuariosNew').'>aqu&iacute;</a>';
                            $class_style = 'errorDialogBox';
                        }
                        
                        return $this->render('ExpidianGlobalBundle::dialog_msj.html.twig', array('msj'=>$msj, 'class'=>$class_style,'breadcrumb'=>$breadcrumb,'usuario'=>$usuario_obj));
                        
                    }
                    
                }

                return $this->render('ExpidianUsuariosBundle:Usuarios:edit_usuarios.html.twig', array('form'=>$form->createView(), 'breadcrumb'=>$breadcrumb,'usuario'=>$usuario_obj, 'opc'=>'Nuevo'));
                
            }else{
                
                return $this->render('ExpidianGlobalBundle::dialog_msj.html.twig', array('msj'=>'Su perfil no posee permisos para efectuar esta acci&oacute;n en el sistema.','class'=>'errorDialogBox', 'breadcrumb'=>$breadcrumb,'usuario'=>$usuario_obj));
                
            }
            
        }else{
            return $this->render('ExpidianUsuariosBundle:Login:login.html.twig', array('accion'=>'login','estatus'=>''));
        } 
    }
    
    public function editAction() {
        
        $request = $this->getRequest();
        $session = $request->getSession();
                
        $sm = new SessionManager($session);
        $sm->readSession();
        
        if($sm->getSession_is_open()){
            
            $breadcrumb = array(array('text'=>'Usuarios','url'=>$this->generateUrl('ExpUsuariosList')),array('text'=>'Editar','url'=>''));
            
            $em = $this->getDoctrine()->getEntityManager();
            $usuario = $em->getRepository('ExpidianGlobalBundle:Usuarios')->find('1');
            
            $usuario_obj = $sm->getUsuario();
            
            $form = $this->createForm(new UsuariosType(),$usuario);
            
            return $this->render('ExpidianUsuariosBundle:Usuarios:edit_usuarios.html.twig', array('form'=>$form->createView(), 'breadcrumb'=>$breadcrumb,'usuario'=>$usuario_obj, 'opc'=>'Editar'));
            
        }else{
            return $this->render('ExpidianUsuariosBundle:Login:login.html.twig', array('accion'=>'login','estatus'=>''));
        } 
        
    }
    
    public function ajaxCheckUsuarioAction(){
        
        $request = $this->getRequest();
        $session = $request->getSession();
        
        $sm = new SessionManager($session);
        $sm->readSession();
        
        $result = false;
                        
        if($request->getMethod()=='POST' && $request->isXmlHttpRequest()){
           
            $em = $this->getDoctrine()->getEntityManager();
            
            $cod_usuario = $request->get('usuario');
            
            $usuario = $em->getRepository('ExpidianGlobalBundle:Usuarios')->findOneBy(array('usuario'=>$cod_usuario));
            
            if(!$usuario){
                $result = true;
            }
            
        }
        
        return new Response("$result");
    }
    
    
    /**
     * Renderiza la lista de usuarios
     * 
     * @return \Symfony\Component\HttpFoundation\Response 
     */
    public function ajaxListaUsuarioAction(){
        
        $request = $this->getRequest();
        
        $session = $request->getSession();
                
        $sm = new SessionManager($session);
        $sm->readSession();
       
        if($request->getMethod()=='POST' && $request->isXmlHttpRequest()){
            
            $usuario_obj = $sm->getUsuario();
            
            if($usuario_obj->getPerfil()->getPerfil()=='Administrador' || $usuario_obj->getPerfil()->getPerfil()=='Abogado Coordinador'){
                
                $_search = $request->request->get('_search');
                $page = $request->request->get('page');
                $rows = $request->request->get('rows');
                $searchField = $request->request->get('searchField');
                $searchOper = $request->request->get('searchOper');
                $searchString = $request->request->get('searchString');
                $sidx = $request->request->get('sidx');
                $sord = $request->request->get('sord');
                
                $em = $this->getDoctrine()->getEntityManager();
                //$qb = $em->getRepository('ExpidianGlobalBundle:Usuarios')->listarUsuarios($_search, $searchField, $searchOper, $searchString, $sidx, $sord, $em);
                $qb = $em->getRepository('ExpidianGlobalBundle:Usuarios')->createQueryBuilder('u');
                $adapter = new DoctrineOrmAdapter($qb);
                $pager = new Pager($adapter,array('page' => $page, 'limit' => $rows));
                
                return $this->render('ExpidianUsuariosBundle:Ajax:table_list_usuarios.html.twig', array('pager'=>$pager,'_search'=>$_search, 'searchField'=>$searchField, 'searchOper'=>$searchOper, 'searchString'=>$searchString, 'sidx'=>$sidx, 'sord'=>$sord, 'rows'=>$rows, 'page'=>$page));
                
            }
            
        }
        
        $msj = 'Ha ocurrido un error en el sistema. Vuelva a intentarlo más tarde.';
        $class_style = 'errorDialogBox';

        return new Response("<div class='$class_style' style='margin: 20px 1.3% 10px;' ><p>$msj</p></div>");
    }
    

}

?>